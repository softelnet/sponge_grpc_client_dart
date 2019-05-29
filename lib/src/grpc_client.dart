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

import 'dart:async';
import 'package:grpc/grpc.dart';
import 'package:logging/logging.dart';
import 'package:sponge_client_dart/sponge_client_dart.dart';
import 'package:sponge_grpc_client_dart/src/generated/sponge.pbgrpc.dart';
import 'package:sponge_grpc_client_dart/src/utils.dart';
import 'package:sync/semaphore.dart';

/// A Sponge gRPC API client.
class SpongeGrpcClient {
  SpongeGrpcClient(this.restClient, {this.channelOptions});

  static final Logger _logger = Logger('SpongeGrpcClient');
  SpongeRestClient restClient;

  ChannelOptions channelOptions = ChannelOptions();
  ClientChannel channel;
  SpongeGrpcApiClient serviceStub;

  /// Keep alive request interval for subscriptions (in seconds). Defaults to 15 minutes.
  int keepAliveInterval = 15 * 60;

  /// Keep alive internal loop interval (in seconds). Defaults to 1 second.
  int keepAliveLoopInterval = 1;

  void open() {
    if (channel != null) {
      return;
    }

    Uri restUri = Uri.parse(restClient.configuration.url);

    var host = restUri.host;
    // Sponge gRPC API service port convention: REST API port + 1.
    var port = (restUri.hasPort ? restUri.port : 80) + 1;
    _logger.info('Connecting to the Sponge gRPC API service $host:$port');

    channel = ClientChannel(host, port: port, options: channelOptions);
    serviceStub = SpongeGrpcApiClient(channel);
  }

  Future<void> close() async {
    await channel?.shutdown();
    channel = null;
  }

  Future<String> getVersion() async {
    var version = (await serviceStub.getVersion(VersionRequest())).version;
    return (version?.isNotEmpty ?? false) ? version : null;
  }

  Subscription subscribe(List<String> eventNames) =>
      Subscription(this, eventNames)..open();
}

class Subscription {
  Subscription(this._grpcClient, this.eventNames);

  static final Logger _logger = Logger('Subscription');

  final SpongeGrpcClient _grpcClient;
  List<String> eventNames;
  bool _subscribed = false;
  bool get subscribed => _subscribed;

  Stream<SpongeEvent> _eventStream;
  Stream<SpongeEvent> get eventStream => _eventStream;

  final _semaphore = Semaphore();

  void open() {
    if (_subscribed) {
      return;
    }

    eventStream = _grpcClient.serviceStub
        .subscribe(_requestStream())
        .asyncMap((response) => SpongeGrpcUtils.createEventFromGrpc(
            _grpcClient.restClient, response.event))
        .asBroadcastStream();
    _subscribed = true;
  }

  set eventStream(Stream<SpongeEvent> value) {
    _eventStream = value;

    value.listen(
      null,
      onError: (e) {
        _subscribed = false;
      },
      onDone: () {
        _subscribed = false;
      },
    );
  }

  Stream<SubscribeRequest> _requestStream() async* {
    await _semaphore.acquire();

    try {
      var request = SubscribeRequest()..eventNames.addAll(eventNames);
      yield request;

      var timestamp = DateTime.now();

      // Send KeepAlive.
      while (_subscribed) {
        var newTimestamp = DateTime.now();
        if (newTimestamp.difference(timestamp).inSeconds >
            _grpcClient.keepAliveInterval) {
          yield request;
          timestamp = newTimestamp;
        }

        await Future.delayed(
            Duration(seconds: _grpcClient.keepAliveLoopInterval));
      }
    } finally {
      _semaphore.release();
    }
  }

  Future<void> close() async {
    _subscribed = false;
    await _semaphore.acquire();
    _semaphore.release();
  }
}