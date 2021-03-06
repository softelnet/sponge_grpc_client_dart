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
import 'package:meta/meta.dart';
import 'package:grpc/grpc_web.dart';
import 'package:logging/logging.dart';
import 'package:sponge_client_dart/sponge_client_dart.dart';
import 'package:sponge_grpc_client_dart/src/grpc_client_base.dart';
import 'package:sponge_grpc_client_dart/src/generated/sponge.pbgrpc.dart';
import 'package:sponge_grpc_client_dart/src/grpc_client_configuration.dart';
import 'package:sponge_grpc_client_dart/src/utils.dart';

/// A Sponge web gRPC API client.
class WebSpongeGrpcClient extends SpongeGrpcClient {
  WebSpongeGrpcClient(
    SpongeClient spongeClient, {
    SpongeGrpcClientConfiguration configuration,
    bool autoOpen = true,
  }) : super(spongeClient, configuration: configuration) {
    if (autoOpen) open();
  }

  static final Logger _logger = Logger('WebSpongeGrpcClient');

  GrpcWebClientChannel _channel;
  GrpcWebClientChannel get channel => _channel;

  @override
  void open() {
    if (_channel != null) {
      return;
    }

    var remoteApiUri = Uri.parse(spongeClient.configuration.url);

    var host = remoteApiUri.host;
    var port = configuration?.port;

    // If the port is not configured explicitly, use the Sponge gRPC Web API service port convention: Remote API port + 2.
    port ??= (remoteApiUri.hasPort
            ? remoteApiUri.port
            : (spongeClient.configuration.secure ? 443 : 80)) +
        2;

    var isSecure = remoteApiUri.isScheme('HTTPS');
    _logger.finer(
        'Creating a new web client to the ${isSecure ? "secure" : "insecure"} Sponge gRPC API service on $host:$port');

    _channel = GrpcWebClientChannel.xhr(
        Uri.parse('${remoteApiUri.scheme}://$host:$port'));
    service = SpongeGrpcApiClient(_channel);
  }

  @override
  Future<void> close({bool terminate = false}) async {
    if (terminate) {
      await _channel?.terminate();
    } else {
      await _channel?.shutdown();
    }
    _channel = null;
  }

  /// The option [managed] is not supported for the web gRPC client.
  @override
  ClientSubscription subscribe(
    List<String> eventNames, {
    bool registeredTypeRequired = false,
    CallOptions options,
    bool managed = true,
  }) {
    Validate.isTrue(!managed,
        'The managed subscription uses gRPC bidirectional streaming that is not supported for a web client');

    return super.subscribe(eventNames,
        registeredTypeRequired: registeredTypeRequired,
        options: options,
        managed: managed);
  }

  @override
  bool isCancelledErrorCode(error) =>
      error is GrpcError && error.code == StatusCode.cancelled;

  @protected
  @override
  void handleError(String operation, Exception exception) {
    GrpcError grpcError = exception is GrpcError ? exception : null;

    if (grpcError != null &&
        SpongeGrpcUtils.isPredefinedGrpcStatusCode(grpcError.code)) {
      throw exception;
    }

    spongeClient.handleErrorResponse(
        operation,
        ResponseError(
            grpcError?.code ?? SpongeClientConstants.ERROR_CODE_GENERIC,
            grpcError?.message ?? exception?.toString()));
  }
}
