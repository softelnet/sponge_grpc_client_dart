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

import 'package:grpc/service_api.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:sponge_client_dart/sponge_client_dart.dart';
import 'package:sponge_grpc_client_dart/src/generated/sponge.pbgrpc.dart';
import 'package:sponge_grpc_client_dart/src/grpc_client_configuration.dart';
import 'package:sponge_grpc_client_dart/src/utils.dart';
import 'package:sync/semaphore.dart';

/// A base Sponge gRPC API client.
abstract class SpongeGrpcClient {
  SpongeGrpcClient(
    SpongeClient spongeClient, {
    SpongeGrpcClientConfiguration configuration,
  })  : _spongeClient = spongeClient,
        _configuration = configuration;

  final SpongeClient _spongeClient;
  SpongeClient get spongeClient => _spongeClient;

  final SpongeGrpcClientConfiguration _configuration;
  SpongeGrpcClientConfiguration get configuration => _configuration;

  SpongeGrpcApiClient _service;
  SpongeGrpcApiClient get service => _service;
  set service(SpongeGrpcApiClient value) => _service = value;

  /// Keep alive request interval for subscriptions (in seconds). Defaults to 15 minutes.
  int keepAliveInterval = 15 * 60;

  /// Keep alive internal loop interval (in seconds). Defaults to 1 second.
  int keepAliveLoopInterval = 1;

  void open();

  Future<void> close({bool terminate = false});

  Future<String> getVersion({CallOptions options}) async {
    var request = VersionRequest()
      ..header = SpongeGrpcUtils.createRequestHeader(_spongeClient);

    var response = await spongeClient.executeWithAuthentication(
        requestUsername: request.header.username,
        requestPassword: request.header.password,
        requestAuthToken: request.header.authToken,
        onExecute: () async {
          try {
            return await _service.getVersion(request, options: options);
          } on Exception catch (e) {
            handleError('getVersion', e);
            rethrow;
          }
        },
        onClearAuthToken: () => request.header.authToken = null);

    return response.hasVersion() ? response.version : null;
  }

  ClientSubscription subscribe(
    List<String> eventNames, {
    bool registeredTypeRequired = false,
    CallOptions options,
    bool managed = true,
  }) =>
      ClientSubscription(this, eventNames,
          registeredTypeRequired: registeredTypeRequired,
          callOptions: options,
          managed: managed)
        .._open();

  /// This method is necessary in order to provide a web gRPC support.
  bool isCancelledErrorCode(dynamic error);

  @protected
  void handleError(String operation, Exception exception);
}

class ClientSubscription {
  ClientSubscription(
    this._grpcClient,
    this._eventNames, {
    bool registeredTypeRequired = false,
    CallOptions callOptions,
    bool managed = true,
  })  : _registeredTypeRequired = registeredTypeRequired,
        _managed = managed,
        _callOptions = callOptions ?? CallOptions();

  static final _logger = Logger('ClientSubscription');

  int _id;
  int get id => _id;
  final SpongeGrpcClient _grpcClient;
  final List<String> _eventNames;
  List<String> get eventNames => _eventNames;
  final bool _registeredTypeRequired;
  bool get registeredTypeRequired => _registeredTypeRequired;
  final CallOptions _callOptions;
  final bool _managed;
  bool _subscribed = false;
  bool get subscribed => _subscribed;
  ResponseStream<SubscribeResponse> _responseStream;

  Stream<RemoteEvent> _eventStream;
  Stream<RemoteEvent> get eventStream => _eventStream;

  final _semaphore = Semaphore();

  void _open() {
    if (_subscribed) {
      return;
    }

    Stream<SubscribeResponse> localResponseStream;

    if (_managed) {
      localResponseStream = _responseStream = _grpcClient.service
          .subscribeManaged(_requestStream(), options: _callOptions);
    } else {
      localResponseStream = _subscribeOnce();
    }

    _setupEventStream(localResponseStream.asyncMap((response) {
      // Set the subscription id from the server.
      if (response.hasSubscriptionId()) {
        _id = response.subscriptionId?.toInt();
      }
      return SpongeGrpcUtils.createEventFromGrpc(
          _grpcClient.spongeClient, response.event);
    }));
    _subscribed = true;
  }

  void _setupEventStream(Stream<RemoteEvent> value) {
    _eventStream = value
        .handleError(
          (error) => _logger.fine(error),
          test: (error) => _grpcClient.isCancelledErrorCode(error),
        )
        .asBroadcastStream();

    _eventStream.listen(
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
    if (_grpcClient.spongeClient.configuration.autoUseAuthToken) {
      // Invoke the synchronous gRPC API operation to ensure the current authToken renewal. The auth token is shared
      // by both the Remote API and gRPC connection. Here the `getVersion` operation is used.
      await _grpcClient.getVersion();
    }

    return SubscribeRequest()
      ..header = SpongeGrpcUtils.createRequestHeader(_grpcClient.spongeClient)
      ..eventNames.addAll(eventNames)
      ..registeredTypeRequired = registeredTypeRequired;
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

  Stream<SubscribeResponse> _subscribeOnce() async* {
    _responseStream = _grpcClient.service.subscribe(
        await _createAndSetupSubscribeRequest(),
        options: _callOptions);
    yield* _responseStream;
  }

  Future<void> close() async {
    _subscribed = false;

    if (_managed) {
      await _semaphore.acquire();
      _semaphore.release();
    } else {
      await _responseStream?.cancel();
    }
  }
}
