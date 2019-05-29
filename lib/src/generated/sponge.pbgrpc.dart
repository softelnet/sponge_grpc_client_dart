///
//  Generated code. Do not modify.
//  source: sponge.proto
///
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'package:grpc/service_api.dart' as $grpc;

import 'dart:core' as $core show int, String, List;

import 'sponge.pb.dart';
export 'sponge.pb.dart';

class SpongeGrpcApiClient extends $grpc.Client {
  static final _$getVersion =
      $grpc.ClientMethod<VersionRequest, VersionResponse>(
          '/org.openksavi.sponge.grpcapi.SpongeGrpcApi/GetVersion',
          (VersionRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => VersionResponse.fromBuffer(value));
  static final _$subscribe =
      $grpc.ClientMethod<SubscribeRequest, SubscribeResponse>(
          '/org.openksavi.sponge.grpcapi.SpongeGrpcApi/Subscribe',
          (SubscribeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => SubscribeResponse.fromBuffer(value));

  SpongeGrpcApiClient($grpc.ClientChannel channel, {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<VersionResponse> getVersion(VersionRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$getVersion, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseStream<SubscribeResponse> subscribe(
      $async.Stream<SubscribeRequest> request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$subscribe, request, options: options);
    return $grpc.ResponseStream(call);
  }
}

abstract class SpongeGrpcApiServiceBase extends $grpc.Service {
  $core.String get $name => 'org.openksavi.sponge.grpcapi.SpongeGrpcApi';

  SpongeGrpcApiServiceBase() {
    $addMethod($grpc.ServiceMethod<VersionRequest, VersionResponse>(
        'GetVersion',
        getVersion_Pre,
        false,
        false,
        ($core.List<$core.int> value) => VersionRequest.fromBuffer(value),
        (VersionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<SubscribeRequest, SubscribeResponse>(
        'Subscribe',
        subscribe,
        true,
        true,
        ($core.List<$core.int> value) => SubscribeRequest.fromBuffer(value),
        (SubscribeResponse value) => value.writeToBuffer()));
  }

  $async.Future<VersionResponse> getVersion_Pre(
      $grpc.ServiceCall call, $async.Future request) async {
    return getVersion(call, await request);
  }

  $async.Future<VersionResponse> getVersion(
      $grpc.ServiceCall call, VersionRequest request);
  $async.Stream<SubscribeResponse> subscribe(
      $grpc.ServiceCall call, $async.Stream<SubscribeRequest> request);
}
