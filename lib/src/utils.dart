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
import 'package:sponge_client_dart/sponge_client_dart.dart';

class SpongeGrpcUtils {
  static Future<SpongeEvent> createEventFromGrpc(
      SpongeRestClient restClient, Event grpcEvent) async {
    var event = SpongeEvent(
        id: grpcEvent.hasId() ? grpcEvent.id : null,
        name: grpcEvent.hasName() ? grpcEvent.name : null,
        priority: grpcEvent.hasPriority() ? grpcEvent.priority : null,
        time: grpcEvent.hasTime()
            ? grpcEvent.time.toDateTime()
            /*DateTime.fromMicrosecondsSinceEpoch(
       grpcEvent.time.seconds.toInt() * 1000000 + grpcEvent.time.nanos ~/ 1000)*/
            : null);

    if (grpcEvent.hasAttributes()) {
      Validate.isTrue(!grpcEvent.attributes.hasValueAny(),
          'Any not supported for an event attributes');
      if (grpcEvent.attributes.hasValueJson() &&
          (grpcEvent.attributes.valueJson?.isNotEmpty ?? false)) {
        Map<String, dynamic> jsonAttributes =
            json.decode(grpcEvent.attributes.valueJson);

        for (var entry in jsonAttributes.entries) {
          // TODO Implement event attribute types.
          event.attributes[entry.key] = await restClient.typeConverter
              .unmarshal(StringType(), entry.value);
        }
      }
    }

    return event;
  }
}
