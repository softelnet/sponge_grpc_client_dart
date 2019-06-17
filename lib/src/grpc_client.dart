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
import 'package:sponge_grpc_client_dart/src/generated/sponge.pbgrpc.dart'
    as grpc;
import 'package:sponge_grpc_client_dart/src/utils.dart';
import 'package:sync/semaphore.dart';

/// A Sponge gRPC API client.
class SpongeGrpcClient {
  SpongeGrpcClient(
    this.restClient, {
    this.channelOptions = const ChannelOptions(),
  }) {
    _open();
  }

  static final Logger _logger = Logger('SpongeGrpcClient');
  SpongeRestClient restClient;

  ChannelOptions channelOptions;
  ClientChannel channel;
  SpongeGrpcApiClient serviceStub;

  /// Keep alive request interval for subscriptions (in seconds). Defaults to 15 minutes.
  int keepAliveInterval = 15 * 60;

  /// Keep alive internal loop interval (in seconds). Defaults to 1 second.
  int keepAliveLoopInterval = 1;

  void _open() {
    if (channel != null) {
      return;
    }

    Uri restUri = Uri.parse(restClient.configuration.url);

    var host = restUri.host;
    // Sponge gRPC API service port convention: REST API port + 1.
    var port = (restUri.hasPort ? restUri.port : 80) + 1;
    bool isSecure = channelOptions?.credentials?.isSecure ?? false;
    _logger.finer(
        'Creating a new client to the ${isSecure ? "secure" : "insecure"} Sponge gRPC API service on $host:$port');

    channel = ClientChannel(host, port: port, options: channelOptions);
    serviceStub = SpongeGrpcApiClient(channel);
  }

  Future<void> close({bool terminate = false}) async {
    if (terminate) {
      await channel?.terminate();
    } else {
      await channel?.shutdown();
    }
    channel = null;
  }

  Future<bool> testConnection() async {
    try {
      await getVersion(options: CallOptions(timeout: Duration(seconds: 1)));
      return true;
    } on GrpcError {
      return false;
    }
  }

  /// Uses the REST client in order to setup the gRPC request header
  /// by reusing the REST API authentication data.
  grpc.RequestHeader createRequestHeader() {
    var restHeader = restClient.setupRequest(SpongeRequest()).header;

    return grpc.RequestHeader.create()
      ..id ??= restHeader.id
      ..username ??= restHeader.username
      ..password ??= restHeader.password
      ..authToken ??= restHeader.authToken;
  }

  void _handleResponseHeader(String operation, grpc.ResponseHeader header) {
    if (header == null) {
      return;
    }

    restClient.handleResponseHeader(
        operation,
        header.hasErrorCode() ? header.errorCode : null,
        header.hasErrorMessage() ? header.errorMessage : null,
        header.hasDetailedErrorMessage() ? header.detailedErrorMessage : null);
  }

  Future<String> getVersion({CallOptions options}) async {
    var request = VersionRequest()..header = createRequestHeader();

    VersionResponse response = await restClient.executeWithAuthentication(
        requestUsername: request.header.username,
        requestPassword: request.header.password,
        requestAuthToken: request.header.authToken,
        onExecute: () async {
          VersionResponse response =
              await serviceStub.getVersion(request, options: options);
          _handleResponseHeader(
              'getVersion', response.hasHeader() ? response.header : null);

          return response;
        },
        onClearAuthToken: () => request.header.authToken = null);

    return response.hasVersion() ? response.version : null;
  }

  Subscription subscribe(List<String> eventNames, {CallOptions options}) =>
      Subscription(this, eventNames, callOptions: options)..open();
}

class Subscription {
  Subscription(this._grpcClient, this.eventNames, {CallOptions callOptions})
      : _callOptions = callOptions ?? CallOptions();

  static final Logger _logger = Logger('Subscription');

  int id;
  final SpongeGrpcClient _grpcClient;
  final List<String> eventNames;
  final CallOptions _callOptions;
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
        .subscribe(_requestStream(), options: _callOptions)
        .asyncMap((response) {
      // Set the subscription id from the server.
      if (response.hasSubscriptionId()) {
        id = response.subscriptionId?.toInt();
      }
      return SpongeGrpcUtils.createEventFromGrpc(
          _grpcClient.restClient, response.event);
    }).asBroadcastStream();
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

  Future<SubscribeRequest> _createAndSetupSubscribeRequest() async {
    if (_grpcClient.restClient.configuration.autoUseAuthToken) {
      // Invoke the synchronous gRPC API operation to ensure the current authToken renewal. The auth token is shared
      // by both the REST and gRPC connection. Here the `getVersion` operation is used.
      await _grpcClient.getVersion();
    }

    return SubscribeRequest()
      ..header = _grpcClient.createRequestHeader()
      ..eventNames.addAll(eventNames);
  }

  Stream<SubscribeRequest> _requestStream() async* {
    await _semaphore.acquire();

    try {
      yield await _createAndSetupSubscribeRequest();

      var timestamp = DateTime.now();

      // Send KeepAlive.
      while (_subscribed) {
        var newTimestamp = DateTime.now();
        if (newTimestamp.difference(timestamp).inSeconds >
            _grpcClient.keepAliveInterval) {
          yield await _createAndSetupSubscribeRequest();
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
