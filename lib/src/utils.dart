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
import 'dart:convert';
import 'package:sponge_grpc_client_dart/src/generated/sponge.pb.dart';
import 'package:sponge_grpc_client_dart/src/generated/sponge.pbgrpc.dart'
    as grpc;
import 'package:sponge_client_dart/sponge_client_dart.dart';

class SpongeGrpcUtils {
  static Future<RemoteEvent> createEventFromGrpc(
      SpongeClient spongeClient, Event grpcEvent) async {
    var event = RemoteEvent(
      id: grpcEvent.hasId() ? grpcEvent.id : null,
      name: grpcEvent.hasName() ? grpcEvent.name : null,
      priority: grpcEvent.hasPriority() ? grpcEvent.priority : null,
      time: grpcEvent.hasTime() ? grpcEvent.time.toDateTime() : null,
      label: grpcEvent.hasLabel() ? grpcEvent.label : null,
      description: grpcEvent.hasDescription() ? grpcEvent.description : null,
    );

    if (grpcEvent.hasAttributes()) {
      Validate.isTrue(!grpcEvent.attributes.hasValueAny(),
          'Any not supported for event attributes');
      if (grpcEvent.attributes.hasValueJson() &&
          (grpcEvent.attributes.valueJson?.isNotEmpty ?? false)) {
        Map<String, dynamic> jsonAttributes =
            json.decode(grpcEvent.attributes.valueJson);
        var eventType = await spongeClient.getEventType(event.name);

        // Unmarshal event attributes only if the event type is registered.
        if (eventType != null) {
          for (var entry in jsonAttributes.entries) {
            event.attributes[entry.key] = await spongeClient.typeConverter
                .unmarshal(eventType.getFieldType(entry.key), entry.value);
          }
        }
      }
    }

    if (grpcEvent.hasFeatures()) {
      Validate.isTrue(!grpcEvent.features.hasValueAny(),
          'Any not supported for event features');
      if (grpcEvent.features.hasValueJson() &&
          (grpcEvent.features.valueJson?.isNotEmpty ?? false)) {
        event.features = await FeaturesUtils.unmarshal(
            spongeClient.typeConverter.featureConverter,
            json.decode(grpcEvent.features.valueJson));
      }
    }

    return event;
  }

  /// Uses the Remote client in order to setup the gRPC request header
  /// by reusing the Remote API authentication data.
  static grpc.RequestHeader createRequestHeader(SpongeClient spongeClient) {
    // Create a fake request to obtain a header.
    var jsonHeader = spongeClient.setupRequest(GetVersionRequest()).header;

    var grpcHeader = grpc.RequestHeader.create();

    if (jsonHeader.username != null) {
      grpcHeader.username = jsonHeader.username;
    }
    if (jsonHeader.password != null) {
      grpcHeader.password = jsonHeader.password;
    }
    if (jsonHeader.authToken != null) {
      grpcHeader.authToken = jsonHeader.authToken;
    }
    if (jsonHeader.features != null) {
      grpcHeader.features = grpc.ObjectValue.create()
        ..valueJson = json.encode(jsonHeader.features);
    }

    return grpcHeader;
  }

  static bool isPredefinedGrpcStatusCode(int code) {
    return code >= 0 && code < SpongeClientConstants.ERROR_CODE_GENERIC;
  }
}
