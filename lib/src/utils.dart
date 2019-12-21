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
      SpongeRestClient restClient, Event grpcEvent) async {
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
          'Any not supported for an event attributes');
      if (grpcEvent.attributes.hasValueJson() &&
          (grpcEvent.attributes.valueJson?.isNotEmpty ?? false)) {
        Map<String, dynamic> jsonAttributes =
            json.decode(grpcEvent.attributes.valueJson);
        var eventType = await restClient.getEventType(event.name);

        // Unmarshal event attributes only if the event type is registered.
        if (eventType != null) {
          for (var entry in jsonAttributes.entries) {
            event.attributes[entry.key] = await restClient.typeConverter
                .unmarshal(eventType.getFieldType(entry.key), entry.value);
          }
        }
      }
    }

    return event;
  }

  /// Uses the REST client in order to setup the gRPC request header
  /// by reusing the REST API authentication data.
  static grpc.RequestHeader createRequestHeader(SpongeRestClient restClient) {
    // Create a fake request to obtain a header.
    var restHeader = restClient.setupRequest(GetVersionRequest()).header;

    var grpcHeader = grpc.RequestHeader.create();

    if (restHeader.id != null) {
      grpcHeader.id = restHeader.id;
    }
    if (restHeader.username != null) {
      grpcHeader.username = restHeader.username;
    }
    if (restHeader.password != null) {
      grpcHeader.password = restHeader.password;
    }
    if (restHeader.authToken != null) {
      grpcHeader.authToken = restHeader.authToken;
    }

    return grpcHeader;
  }

  static void handleResponseHeader(SpongeRestClient restClient,
      String operation, grpc.ResponseHeader header) {
    if (header == null) {
      return;
    }

    restClient.handleResponseHeader(
        operation,
        header.hasErrorCode() ? header.errorCode : null,
        header.hasErrorMessage() ? header.errorMessage : null,
        header.hasDetailedErrorMessage() ? header.detailedErrorMessage : null);
  }
}
