///
//  Generated code. Do not modify.
//  source: sponge.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'sponge.pb.dart' as $0;
export 'sponge.pb.dart';

class SpongeGrpcApiClient extends $grpc.Client {
  static final _$getVersion =
      $grpc.ClientMethod<$0.VersionRequest, $0.VersionResponse>(
          '/org.openksavi.sponge.grpcapi.SpongeGrpcApi/GetVersion',
          ($0.VersionRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.VersionResponse.fromBuffer(value));
  static final _$subscribe =
      $grpc.ClientMethod<$0.SubscribeRequest, $0.SubscribeResponse>(
          '/org.openksavi.sponge.grpcapi.SpongeGrpcApi/Subscribe',
          ($0.SubscribeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.SubscribeResponse.fromBuffer(value));

  SpongeGrpcApiClient($grpc.ClientChannel channel, {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$0.VersionResponse> getVersion($0.VersionRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$getVersion, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseStream<$0.SubscribeResponse> subscribe(
      $async.Stream<$0.SubscribeRequest> request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$subscribe, request, options: options);
    return $grpc.ResponseStream(call);
  }
}

abstract class SpongeGrpcApiServiceBase extends $grpc.Service {
  $core.String get $name => 'org.openksavi.sponge.grpcapi.SpongeGrpcApi';

  SpongeGrpcApiServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.VersionRequest, $0.VersionResponse>(
        'GetVersion',
        getVersion_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.VersionRequest.fromBuffer(value),
        ($0.VersionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SubscribeRequest, $0.SubscribeResponse>(
        'Subscribe',
        subscribe,
        true,
        true,
        ($core.List<$core.int> value) => $0.SubscribeRequest.fromBuffer(value),
        ($0.SubscribeResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.VersionResponse> getVersion_Pre(
      $grpc.ServiceCall call, $async.Future<$0.VersionRequest> request) async {
    return getVersion(call, await request);
  }

  $async.Future<$0.VersionResponse> getVersion(
      $grpc.ServiceCall call, $0.VersionRequest request);
  $async.Stream<$0.SubscribeResponse> subscribe(
      $grpc.ServiceCall call, $async.Stream<$0.SubscribeRequest> request);
}
