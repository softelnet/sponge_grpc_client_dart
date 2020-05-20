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
import 'package:sponge_client_dart/sponge_client_dart.dart';
import 'package:sponge_grpc_client_dart/sponge_grpc_client_dart.dart';

void main() async {
  // Create a new Sponge Remote API client.
  var spongeClient =
      SpongeClient(SpongeClientConfiguration('http://localhost:8888'));

  // Create a new Sponge gRPC API client associated with the Remote API client.
  // Don't use insecure channel in production.
  var grpcClient = DefaultSpongeGrpcClient(spongeClient,
      channelOptions:
          ChannelOptions(credentials: const ChannelCredentials.insecure()));

  // Get the Sponge Remote API version.
  var version = await grpcClient.getVersion();

  print('Version: $version');

  // Close the client connection.
  await grpcClient.close();
}
