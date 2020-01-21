///
//  Generated code. Do not modify.
//  source: sponge.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/any.pb.dart' as $1;
import 'google/protobuf/timestamp.pb.dart' as $2;

enum ObjectValue_ValueOneof { valueJson, valueAny, notSet }

class ObjectValue extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, ObjectValue_ValueOneof>
      _ObjectValue_ValueOneofByTag = {
    1: ObjectValue_ValueOneof.valueJson,
    2: ObjectValue_ValueOneof.valueAny,
    0: ObjectValue_ValueOneof.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ObjectValue',
      package: const $pb.PackageName('org.openksavi.sponge.grpcapi'),
      createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOS(1, 'valueJson')
    ..aOM<$1.Any>(2, 'valueAny', subBuilder: $1.Any.create)
    ..hasRequiredFields = false;

  ObjectValue._() : super();
  factory ObjectValue() => create();
  factory ObjectValue.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ObjectValue.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  ObjectValue clone() => ObjectValue()..mergeFromMessage(this);
  ObjectValue copyWith(void Function(ObjectValue) updates) =>
      super.copyWith((message) => updates(message as ObjectValue));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ObjectValue create() => ObjectValue._();
  ObjectValue createEmptyInstance() => create();
  static $pb.PbList<ObjectValue> createRepeated() => $pb.PbList<ObjectValue>();
  @$core.pragma('dart2js:noInline')
  static ObjectValue getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ObjectValue>(create);
  static ObjectValue _defaultInstance;

  ObjectValue_ValueOneof whichValueOneof() =>
      _ObjectValue_ValueOneofByTag[$_whichOneof(0)];
  void clearValueOneof() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get valueJson => $_getSZ(0);
  @$pb.TagNumber(1)
  set valueJson($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasValueJson() => $_has(0);
  @$pb.TagNumber(1)
  void clearValueJson() => clearField(1);

  @$pb.TagNumber(2)
  $1.Any get valueAny => $_getN(1);
  @$pb.TagNumber(2)
  set valueAny($1.Any v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasValueAny() => $_has(1);
  @$pb.TagNumber(2)
  void clearValueAny() => clearField(2);
  @$pb.TagNumber(2)
  $1.Any ensureValueAny() => $_ensure(1);
}

class Event extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Event',
      package: const $pb.PackageName('org.openksavi.sponge.grpcapi'),
      createEmptyInstance: create)
    ..aOS(1, 'id')
    ..aOS(2, 'name')
    ..aOM<$2.Timestamp>(3, 'time', subBuilder: $2.Timestamp.create)
    ..a<$core.int>(4, 'priority', $pb.PbFieldType.O3)
    ..aOS(5, 'label')
    ..aOS(6, 'description')
    ..aOM<ObjectValue>(7, 'attributes', subBuilder: ObjectValue.create)
    ..hasRequiredFields = false;

  Event._() : super();
  factory Event() => create();
  factory Event.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Event.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  Event clone() => Event()..mergeFromMessage(this);
  Event copyWith(void Function(Event) updates) =>
      super.copyWith((message) => updates(message as Event));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Event create() => Event._();
  Event createEmptyInstance() => create();
  static $pb.PbList<Event> createRepeated() => $pb.PbList<Event>();
  @$core.pragma('dart2js:noInline')
  static Event getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Event>(create);
  static Event _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $2.Timestamp get time => $_getN(2);
  @$pb.TagNumber(3)
  set time($2.Timestamp v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasTime() => $_has(2);
  @$pb.TagNumber(3)
  void clearTime() => clearField(3);
  @$pb.TagNumber(3)
  $2.Timestamp ensureTime() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.int get priority => $_getIZ(3);
  @$pb.TagNumber(4)
  set priority($core.int v) {
    $_setSignedInt32(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasPriority() => $_has(3);
  @$pb.TagNumber(4)
  void clearPriority() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get label => $_getSZ(4);
  @$pb.TagNumber(5)
  set label($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasLabel() => $_has(4);
  @$pb.TagNumber(5)
  void clearLabel() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get description => $_getSZ(5);
  @$pb.TagNumber(6)
  set description($core.String v) {
    $_setString(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasDescription() => $_has(5);
  @$pb.TagNumber(6)
  void clearDescription() => clearField(6);

  @$pb.TagNumber(7)
  ObjectValue get attributes => $_getN(6);
  @$pb.TagNumber(7)
  set attributes(ObjectValue v) {
    setField(7, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasAttributes() => $_has(6);
  @$pb.TagNumber(7)
  void clearAttributes() => clearField(7);
  @$pb.TagNumber(7)
  ObjectValue ensureAttributes() => $_ensure(6);
}

class RequestHeader extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('RequestHeader',
      package: const $pb.PackageName('org.openksavi.sponge.grpcapi'),
      createEmptyInstance: create)
    ..aOS(1, 'id')
    ..aOS(2, 'username')
    ..aOS(3, 'password')
    ..aOS(4, 'authToken')
    ..aOM<ObjectValue>(5, 'features', subBuilder: ObjectValue.create)
    ..hasRequiredFields = false;

  RequestHeader._() : super();
  factory RequestHeader() => create();
  factory RequestHeader.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory RequestHeader.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  RequestHeader clone() => RequestHeader()..mergeFromMessage(this);
  RequestHeader copyWith(void Function(RequestHeader) updates) =>
      super.copyWith((message) => updates(message as RequestHeader));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RequestHeader create() => RequestHeader._();
  RequestHeader createEmptyInstance() => create();
  static $pb.PbList<RequestHeader> createRepeated() =>
      $pb.PbList<RequestHeader>();
  @$core.pragma('dart2js:noInline')
  static RequestHeader getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RequestHeader>(create);
  static RequestHeader _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get username => $_getSZ(1);
  @$pb.TagNumber(2)
  set username($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasUsername() => $_has(1);
  @$pb.TagNumber(2)
  void clearUsername() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get password => $_getSZ(2);
  @$pb.TagNumber(3)
  set password($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasPassword() => $_has(2);
  @$pb.TagNumber(3)
  void clearPassword() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get authToken => $_getSZ(3);
  @$pb.TagNumber(4)
  set authToken($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasAuthToken() => $_has(3);
  @$pb.TagNumber(4)
  void clearAuthToken() => clearField(4);

  @$pb.TagNumber(5)
  ObjectValue get features => $_getN(4);
  @$pb.TagNumber(5)
  set features(ObjectValue v) {
    setField(5, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasFeatures() => $_has(4);
  @$pb.TagNumber(5)
  void clearFeatures() => clearField(5);
  @$pb.TagNumber(5)
  ObjectValue ensureFeatures() => $_ensure(4);
}

class ResponseHeader extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ResponseHeader',
      package: const $pb.PackageName('org.openksavi.sponge.grpcapi'),
      createEmptyInstance: create)
    ..aOS(1, 'id')
    ..aOS(2, 'errorCode')
    ..aOS(3, 'errorMessage')
    ..aOS(4, 'detailedErrorMessage')
    ..hasRequiredFields = false;

  ResponseHeader._() : super();
  factory ResponseHeader() => create();
  factory ResponseHeader.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ResponseHeader.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  ResponseHeader clone() => ResponseHeader()..mergeFromMessage(this);
  ResponseHeader copyWith(void Function(ResponseHeader) updates) =>
      super.copyWith((message) => updates(message as ResponseHeader));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ResponseHeader create() => ResponseHeader._();
  ResponseHeader createEmptyInstance() => create();
  static $pb.PbList<ResponseHeader> createRepeated() =>
      $pb.PbList<ResponseHeader>();
  @$core.pragma('dart2js:noInline')
  static ResponseHeader getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ResponseHeader>(create);
  static ResponseHeader _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get errorCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorCode($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get detailedErrorMessage => $_getSZ(3);
  @$pb.TagNumber(4)
  set detailedErrorMessage($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasDetailedErrorMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearDetailedErrorMessage() => clearField(4);
}

class VersionRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('VersionRequest',
      package: const $pb.PackageName('org.openksavi.sponge.grpcapi'),
      createEmptyInstance: create)
    ..aOM<RequestHeader>(1, 'header', subBuilder: RequestHeader.create)
    ..hasRequiredFields = false;

  VersionRequest._() : super();
  factory VersionRequest() => create();
  factory VersionRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory VersionRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  VersionRequest clone() => VersionRequest()..mergeFromMessage(this);
  VersionRequest copyWith(void Function(VersionRequest) updates) =>
      super.copyWith((message) => updates(message as VersionRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VersionRequest create() => VersionRequest._();
  VersionRequest createEmptyInstance() => create();
  static $pb.PbList<VersionRequest> createRepeated() =>
      $pb.PbList<VersionRequest>();
  @$core.pragma('dart2js:noInline')
  static VersionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VersionRequest>(create);
  static VersionRequest _defaultInstance;

  @$pb.TagNumber(1)
  RequestHeader get header => $_getN(0);
  @$pb.TagNumber(1)
  set header(RequestHeader v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasHeader() => $_has(0);
  @$pb.TagNumber(1)
  void clearHeader() => clearField(1);
  @$pb.TagNumber(1)
  RequestHeader ensureHeader() => $_ensure(0);
}

class VersionResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('VersionResponse',
      package: const $pb.PackageName('org.openksavi.sponge.grpcapi'),
      createEmptyInstance: create)
    ..aOM<ResponseHeader>(1, 'header', subBuilder: ResponseHeader.create)
    ..aOS(2, 'version')
    ..hasRequiredFields = false;

  VersionResponse._() : super();
  factory VersionResponse() => create();
  factory VersionResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory VersionResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  VersionResponse clone() => VersionResponse()..mergeFromMessage(this);
  VersionResponse copyWith(void Function(VersionResponse) updates) =>
      super.copyWith((message) => updates(message as VersionResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VersionResponse create() => VersionResponse._();
  VersionResponse createEmptyInstance() => create();
  static $pb.PbList<VersionResponse> createRepeated() =>
      $pb.PbList<VersionResponse>();
  @$core.pragma('dart2js:noInline')
  static VersionResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VersionResponse>(create);
  static VersionResponse _defaultInstance;

  @$pb.TagNumber(1)
  ResponseHeader get header => $_getN(0);
  @$pb.TagNumber(1)
  set header(ResponseHeader v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasHeader() => $_has(0);
  @$pb.TagNumber(1)
  void clearHeader() => clearField(1);
  @$pb.TagNumber(1)
  ResponseHeader ensureHeader() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get version => $_getSZ(1);
  @$pb.TagNumber(2)
  set version($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearVersion() => clearField(2);
}

class SubscribeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('SubscribeRequest',
      package: const $pb.PackageName('org.openksavi.sponge.grpcapi'),
      createEmptyInstance: create)
    ..aOM<RequestHeader>(1, 'header', subBuilder: RequestHeader.create)
    ..pPS(2, 'eventNames')
    ..aOB(3, 'registeredTypeRequired')
    ..hasRequiredFields = false;

  SubscribeRequest._() : super();
  factory SubscribeRequest() => create();
  factory SubscribeRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SubscribeRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  SubscribeRequest clone() => SubscribeRequest()..mergeFromMessage(this);
  SubscribeRequest copyWith(void Function(SubscribeRequest) updates) =>
      super.copyWith((message) => updates(message as SubscribeRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SubscribeRequest create() => SubscribeRequest._();
  SubscribeRequest createEmptyInstance() => create();
  static $pb.PbList<SubscribeRequest> createRepeated() =>
      $pb.PbList<SubscribeRequest>();
  @$core.pragma('dart2js:noInline')
  static SubscribeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubscribeRequest>(create);
  static SubscribeRequest _defaultInstance;

  @$pb.TagNumber(1)
  RequestHeader get header => $_getN(0);
  @$pb.TagNumber(1)
  set header(RequestHeader v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasHeader() => $_has(0);
  @$pb.TagNumber(1)
  void clearHeader() => clearField(1);
  @$pb.TagNumber(1)
  RequestHeader ensureHeader() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<$core.String> get eventNames => $_getList(1);

  @$pb.TagNumber(3)
  $core.bool get registeredTypeRequired => $_getBF(2);
  @$pb.TagNumber(3)
  set registeredTypeRequired($core.bool v) {
    $_setBool(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasRegisteredTypeRequired() => $_has(2);
  @$pb.TagNumber(3)
  void clearRegisteredTypeRequired() => clearField(3);
}

class SubscribeResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('SubscribeResponse',
      package: const $pb.PackageName('org.openksavi.sponge.grpcapi'),
      createEmptyInstance: create)
    ..aOM<ResponseHeader>(1, 'header', subBuilder: ResponseHeader.create)
    ..aInt64(2, 'subscriptionId')
    ..aOM<Event>(3, 'event', subBuilder: Event.create)
    ..hasRequiredFields = false;

  SubscribeResponse._() : super();
  factory SubscribeResponse() => create();
  factory SubscribeResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SubscribeResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  SubscribeResponse clone() => SubscribeResponse()..mergeFromMessage(this);
  SubscribeResponse copyWith(void Function(SubscribeResponse) updates) =>
      super.copyWith((message) => updates(message as SubscribeResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SubscribeResponse create() => SubscribeResponse._();
  SubscribeResponse createEmptyInstance() => create();
  static $pb.PbList<SubscribeResponse> createRepeated() =>
      $pb.PbList<SubscribeResponse>();
  @$core.pragma('dart2js:noInline')
  static SubscribeResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubscribeResponse>(create);
  static SubscribeResponse _defaultInstance;

  @$pb.TagNumber(1)
  ResponseHeader get header => $_getN(0);
  @$pb.TagNumber(1)
  set header(ResponseHeader v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasHeader() => $_has(0);
  @$pb.TagNumber(1)
  void clearHeader() => clearField(1);
  @$pb.TagNumber(1)
  ResponseHeader ensureHeader() => $_ensure(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get subscriptionId => $_getI64(1);
  @$pb.TagNumber(2)
  set subscriptionId($fixnum.Int64 v) {
    $_setInt64(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasSubscriptionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSubscriptionId() => clearField(2);

  @$pb.TagNumber(3)
  Event get event => $_getN(2);
  @$pb.TagNumber(3)
  set event(Event v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasEvent() => $_has(2);
  @$pb.TagNumber(3)
  void clearEvent() => clearField(3);
  @$pb.TagNumber(3)
  Event ensureEvent() => $_ensure(2);
}
