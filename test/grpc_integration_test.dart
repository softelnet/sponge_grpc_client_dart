// Copyright 2019 The Sponge authors.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:grpc/grpc.dart';
import 'package:logging/logging.dart';
import 'package:pedantic/pedantic.dart';
import 'package:sponge_client_dart/sponge_client_dart.dart';
import 'package:sponge_grpc_client_dart/src/grpc_client.dart';
import 'package:sponge_grpc_client_dart/src/grpc_client_base.dart';
import 'package:sponge_grpc_client_dart/src/grpc_client_configuration.dart';
import 'package:test/test.dart';
import 'package:collection/collection.dart';
import 'logger_configuration.dart';

/// This integration test requires the sponge-examples-project-remote-api-client-test-service/RemoteApiClientTestServiceMain
/// service running on the localhost.
///
/// Note: No other tests should be running using this service at the same time.
void main() {
  configLogger();

  final _logger = Logger('Test');

  Future<SpongeClient> getClient() async =>
      SpongeClient(SpongeClientConfiguration('http://localhost:8888'));
  group('gRPC client', () {
    test('testVersion', () async {
      var restClient = await getClient();
      // Insecure channel only for tests.
      var grpcClient = DefaultSpongeGrpcClient(restClient,
          channelOptions:
              ChannelOptions(credentials: const ChannelCredentials.insecure()));

      var version = await grpcClient.getVersion();

      expect(version, equals(await restClient.getVersion()));
      _logger.info('Version: $version');

      await grpcClient.close();
    });

    Future<void> _testSubscribe(bool managed) async {
      var restClient = await getClient();
      // Insecure channel only for tests.
      var grpcClient = DefaultSpongeGrpcClient(restClient,
          channelOptions:
              ChannelOptions(credentials: const ChannelCredentials.insecure()));

      var maxEvents = 3;
      final events = <RemoteEvent>[];

      var eventNames = ['notification.*'];
      var subscription = grpcClient.subscribe(eventNames,
          registeredTypeRequired: true, managed: managed);

      subscription.eventStream.listen(
        (event) async {
          if (events.length >= maxEvents) {
            await subscription.close();
          } else {
            _logger.info('Adding event: ${event.name}, ${event.attributes}');
            events.add(event);
          }
        },
        onError: (e) {
          _logger.severe('Error: $e');
        },
        onDone: () {
          _logger.info('Done');
        },
      );

      expect(subscription.eventNames, equals(eventNames));
      expect(subscription.registeredTypeRequired, isTrue);
      expect(subscription.subscribed, isTrue);

      // Wait for finish.
      await subscription.eventStream
          .timeout(Duration(seconds: 30))
          .listen((_) {})
          .asFuture();

      await subscription.close();

      expect(events.length, equals(maxEvents));
      expect(subscription.subscribed, isFalse);

      expect(events[1].attributes['source'], equals('Sponge'));

      await subscription?.close();
      await grpcClient.close();
    }

    test('testSubscribeManaged', () async => await _testSubscribe(true));
    test('testSubscribeNotManaged', () async => await _testSubscribe(false));
    test('testRemoteApiFeatures', () async {
      var restClient = await getClient();
      var features = await restClient.getFeatures();
      expect(features[SpongeClientConstants.REMOTE_API_FEATURE_GRPC_ENABLED],
          isTrue);
    });
    test('testPortChange', () async {
      var restClient = await getClient();
      // Insecure channel only for tests.
      var grpcClient = DefaultSpongeGrpcClient(restClient,
          configuration: SpongeGrpcClientConfiguration(
            port: 9000,
          ),
          channelOptions:
              ChannelOptions(credentials: const ChannelCredentials.insecure()));

      try {
        await grpcClient.getVersion();

        fail('Exception expected');
      } catch (e) {
        expect(
            e,
            isA<GrpcError>().having(
                (ex) => ex.code, 'status', equals(StatusCode.unavailable)));
      }

      await grpcClient.close();
    });

    Future<RemoteEvent> _waitForEvent(
      SpongeGrpcClient grpcClient,
      String eventName,
      Future<void> Function() onSend,
      bool Function(RemoteEvent) predicate,
    ) async {
      var subscription =
          grpcClient.subscribe([eventName], registeredTypeRequired: true);

      RemoteEvent receivedEvent;

      subscription.eventStream.listen(
        (event) async {
          if (event.name == eventName && predicate(event)) {
            receivedEvent = event;
            unawaited(subscription.close());
          }
        },
        onError: (e) {
          _logger.severe('Error: $e');
        },
      );

      await Future.delayed(const Duration(seconds: 1));

      await onSend();

      // Block while waiting for the event.
      await subscription.eventStream
          .timeout(Duration(seconds: 30))
          .listen((_) {})
          .asFuture();

      await subscription.close();

      return receivedEvent;
    }

    test('testSendEventAction', () async {
      var eventName = 'notification';
      var eventLabel = 'NOTIFICATION LABEL';
      var eventAttributes = {
        'source': 'SOURCE',
        'severity': 5,
        'person': {'firstName': 'James', 'surname': 'Joyce'}
      };

      var restClient = await getClient()
        ..configuration.username = 'john'
        ..configuration.password = 'password';

      // Insecure channel only for tests.
      var grpcClient = DefaultSpongeGrpcClient(restClient,
          channelOptions:
              ChannelOptions(credentials: const ChannelCredentials.insecure()));

      var receivedEvent = await _waitForEvent(
        grpcClient,
        eventName,
        () async {
          var sendEventActionName = 'GrpcApiSendEvent';
          var providedArgs = await restClient
              .provideActionArgs(sendEventActionName, provide: ['name']);

          expect(providedArgs.length, 1);
          expect(providedArgs['name'].annotatedValueSet.length, 1);

          providedArgs = await restClient.provideActionArgs(
            sendEventActionName,
            provide: ['attributes'],
            current: {'name': eventName},
          );
          var providedAttributes =
              (providedArgs['attributes'].value as DynamicValue).value;
          expect(providedAttributes.length, 0);

          var eventType = await restClient.getEventType(eventName);
          expect(eventType, isNotNull);

          // Send a new event by the action.
          await restClient.call(sendEventActionName, [
            eventName,
            DynamicValue(eventAttributes, eventType),
            eventLabel,
            null
          ]);
        },
        (event) =>
            DeepCollectionEquality()
                .equals(event.attributes, eventAttributes) &&
            event.label == eventLabel,
      );

      expect(receivedEvent, isNotNull);

      await grpcClient.close();
    });

    test('testSendEvent', () async {
      var eventName = 'notification';
      var eventLabel = 'NOTIFICATION LABEL';
      var eventDescription = 'NOTIFICATION DESCRIPTION';
      var eventAttributes = {
        'source': 'SOURCE',
        'severity': 5,
        'person': {'firstName': 'James', 'surname': 'Joyce'}
      };
      var eventFeatures = {
        'icon': IconInfo(name: 'alarm', color: 'FFFFFF'),
        'extra': 'Extra feature'
      };

      var restClient = await getClient()
        ..configuration.username = 'john'
        ..configuration.password = 'password';

      // Insecure channel only for tests.
      var grpcClient = DefaultSpongeGrpcClient(restClient,
          channelOptions:
              ChannelOptions(credentials: const ChannelCredentials.insecure()));

      var predicate = (event) =>
          event.features['icon'] != null &&
          (event.features['icon'] as IconInfo).name ==
              (eventFeatures['icon'] as IconInfo).name &&
          (event.features['icon'] as IconInfo).color ==
              (eventFeatures['icon'] as IconInfo).color &&
          event.features['extra'] == eventFeatures['extra'];

      var receivedEvent = await _waitForEvent(
        grpcClient,
        eventName,
        () async => await restClient.send(
          eventName,
          attributes: eventAttributes,
          label: eventLabel,
          description: eventDescription,
          features: eventFeatures,
        ),
        (event) =>
            DeepCollectionEquality()
                .equals(event.attributes, eventAttributes) &&
            predicate(event) &&
            event.label == eventLabel &&
            event.description == eventDescription,
      );

      expect(receivedEvent, isNotNull);

      await grpcClient.close();
    });
  });
}
