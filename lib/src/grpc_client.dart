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
import 'package:sponge_grpc_client_dart/src/grpc_client_base.dart';
import 'package:sponge_grpc_client_dart/src/generated/sponge.pbgrpc.dart';
import 'package:sponge_grpc_client_dart/src/grpc_client_configuration.dart';

/// A Sponge gRPC API client.
class DefaultSpongeGrpcClient extends SpongeGrpcClient {
  DefaultSpongeGrpcClient(
    SpongeClient spongeClient, {
    SpongeGrpcClientConfiguration configuration,
    ChannelOptions channelOptions = const ChannelOptions(),
    bool autoOpen = true,
  })  : _channelOptions = channelOptions,
        super(spongeClient, configuration: configuration) {
    if (autoOpen) open();
  }

  static final _logger = Logger('DefaultSpongeGrpcClient');

  final ChannelOptions _channelOptions;
  ChannelOptions get channelOptions => _channelOptions;

  ClientChannel _channel;
  ClientChannel get channel => _channel;

  @override
  void open() {
    if (_channel != null) {
      return;
    }

    var restUri = Uri.parse(spongeClient.configuration.url);

    var host = restUri.host;
    var port = configuration?.port;

    // If the port is not configured explicitly, use the Sponge gRPC API service port convention: Remote API port + 1.
    port ??= (restUri.hasPort
            ? restUri.port
            : (spongeClient.configuration.secure ? 443 : 80)) +
        1;
    var isSecure = _channelOptions?.credentials?.isSecure ?? false;
    _logger.finer(
        'Creating a new client to the ${isSecure ? "secure" : "insecure"} Sponge gRPC API service on $host:$port');

    _channel = ClientChannel(host, port: port, options: _channelOptions);
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

  @override
  bool isCancelledErrorCode(error) =>
      error is GrpcError && error.code == StatusCode.cancelled;
}
