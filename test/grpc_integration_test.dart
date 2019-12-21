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
import 'package:sponge_client_dart/sponge_client_dart.dart';
import 'package:sponge_grpc_client_dart/src/grpc_client.dart';
import 'package:sponge_grpc_client_dart/src/grpc_client_configuration.dart';
import 'package:test/test.dart';
import 'logger_configuration.dart';

/// This integration test requires the sponge-examples-project-remote-api-client-test-service/RemoteApiClientTestServiceMain
/// service running on the localhost.
///
/// Note: No other tests should be running using this service at the same time.
void main() {
  configLogger();

  final _logger = Logger('Test');

  Future<SpongeRestClient> getClient() async => SpongeRestClient(
      SpongeRestClientConfiguration('http://localhost:8888/sponge.json/v1'));
  group('gRPC client', () {
    test('testVersion', () async {
      var restClient = await getClient();
      // Insecure channel only for tests.
      var grpcClient = SpongeGrpcClient(restClient,
          channelOptions:
              ChannelOptions(credentials: const ChannelCredentials.insecure()));

      var version = await grpcClient.getVersion();

      expect(version, equals(await restClient.getVersion()));
      _logger.info('Version: $version');

      await grpcClient.close();
    });
    test('testSubscribe', () async {
      var restClient = await getClient();
      // Insecure channel only for tests.
      var grpcClient = SpongeGrpcClient(restClient,
          channelOptions:
              ChannelOptions(credentials: const ChannelCredentials.insecure()));

      var maxEvents = 3;
      final events = <RemoteEvent>[];

      var eventNames = ['notification.*'];
      var subscription =
          grpcClient.subscribe(eventNames, registeredTypeRequired: true);

      subscription.eventStream.listen(
        (event) async {
          _logger.info('Adding event: ${event.name}, ${event.attributes}');
          events.add(event);

          if (events.length >= maxEvents) {
            await subscription.close();
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
    });
    test('testRemoteApiFeatures', () async {
      var restClient = await getClient();
      var features = await restClient.getFeatures();
      expect(features.length, equals(1));
      expect(features[SpongeClientConstants.REMOTE_API_FEATURE_GRPC_ENABLED],
          isTrue);
    });
    test('testPortChange', () async {
      var restClient = await getClient();
      // Insecure channel only for tests.
      var grpcClient = SpongeGrpcClient(restClient,
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
  });
}
