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
import 'package:test/test.dart';
import 'logger_configuration.dart';

/// This integration test requires the sponge-examples-project-remote-api-client-test-service/RemoteApiClientTestServiceMain
/// service running on the localhost.
///
/// Note: No other tests should be running using this service at the same time.
void main() {
  configLogger();

  final Logger _logger = Logger('Test');

  getClient() async => SpongeRestClient(
      SpongeRestClientConfiguration('http://localhost:8888/sponge.json/v1'));
  group('gRPC client', () {
    test('version', () async {
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
    test('subscribe', () async {
      var restClient = await getClient();
      // Insecure channel only for tests.
      var grpcClient = SpongeGrpcClient(restClient,
          channelOptions:
              ChannelOptions(credentials: const ChannelCredentials.insecure()));

      int maxEvents = 3;
      final List<SpongeEvent> events = [];

      Subscription subscription = grpcClient.subscribe(['notification.*']);

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

      // Wait for finish.
      await subscription.eventStream
          .timeout(Duration(seconds: 30))
          .listen((_) {})
          .asFuture();

      expect(events.length, equals(maxEvents));

      // TODO Assertion for attributes.

      await subscription?.close();
      await grpcClient.close();
    });
  });
}
