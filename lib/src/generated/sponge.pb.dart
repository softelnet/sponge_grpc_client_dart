///
//  Generated code. Do not modify.
//  source: sponge.proto
///
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name

import 'dart:core' as $core
    show bool, Deprecated, double, int, List, Map, override, String;

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/any.pb.dart' as $0;
import 'google/protobuf/timestamp.pb.dart' as $1;

enum ObjectValue_ValueOneof { valueJson, valueAny, notSet }

class ObjectValue extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, ObjectValue_ValueOneof>
      _ObjectValue_ValueOneofByTag = {
    1: ObjectValue_ValueOneof.valueJson,
    2: ObjectValue_ValueOneof.valueAny,
    0: ObjectValue_ValueOneof.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ObjectValue',
      package: const $pb.PackageName('org.openksavi.sponge.grpcapi'))
    ..aOS(1, 'valueJson')
    ..a<$0.Any>(
        2, 'valueAny', $pb.PbFieldType.OM, $0.Any.getDefault, $0.Any.create)
    ..oo(0, [1, 2])
    ..hasRequiredFields = false;

  ObjectValue() : super();
  ObjectValue.fromBuffer($core.List<$core.int> i,
      [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  ObjectValue.fromJson($core.String i,
      [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  ObjectValue clone() => ObjectValue()..mergeFromMessage(this);
  ObjectValue copyWith(void Function(ObjectValue) updates) =>
      super.copyWith((message) => updates(message as ObjectValue));
  $pb.BuilderInfo get info_ => _i;
  static ObjectValue create() => ObjectValue();
  ObjectValue createEmptyInstance() => create();
  static $pb.PbList<ObjectValue> createRepeated() => $pb.PbList<ObjectValue>();
  static ObjectValue getDefault() => _defaultInstance ??= create()..freeze();
  static ObjectValue _defaultInstance;

  ObjectValue_ValueOneof whichValueOneof() =>
      _ObjectValue_ValueOneofByTag[$_whichOneof(0)];
  void clearValueOneof() => clearField($_whichOneof(0));

  $core.String get valueJson => $_getS(0, '');
  set valueJson($core.String v) {
    $_setString(0, v);
  }

  $core.bool hasValueJson() => $_has(0);
  void clearValueJson() => clearField(1);

  $0.Any get valueAny => $_getN(1);
  set valueAny($0.Any v) {
    setField(2, v);
  }

  $core.bool hasValueAny() => $_has(1);
  void clearValueAny() => clearField(2);
}

class Event extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Event',
      package: const $pb.PackageName('org.openksavi.sponge.grpcapi'))
    ..aOS(1, 'id')
    ..aOS(2, 'name')
    ..a<$1.Timestamp>(3, 'time', $pb.PbFieldType.OM, $1.Timestamp.getDefault,
        $1.Timestamp.create)
    ..a<$core.int>(4, 'priority', $pb.PbFieldType.O3)
    ..a<ObjectValue>(5, 'attributes', $pb.PbFieldType.OM,
        ObjectValue.getDefault, ObjectValue.create)
    ..hasRequiredFields = false;

  Event() : super();
  Event.fromBuffer($core.List<$core.int> i,
      [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  Event.fromJson($core.String i,
      [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  Event clone() => Event()..mergeFromMessage(this);
  Event copyWith(void Function(Event) updates) =>
      super.copyWith((message) => updates(message as Event));
  $pb.BuilderInfo get info_ => _i;
  static Event create() => Event();
  Event createEmptyInstance() => create();
  static $pb.PbList<Event> createRepeated() => $pb.PbList<Event>();
  static Event getDefault() => _defaultInstance ??= create()..freeze();
  static Event _defaultInstance;

  $core.String get id => $_getS(0, '');
  set id($core.String v) {
    $_setString(0, v);
  }

  $core.bool hasId() => $_has(0);
  void clearId() => clearField(1);

  $core.String get name => $_getS(1, '');
  set name($core.String v) {
    $_setString(1, v);
  }

  $core.bool hasName() => $_has(1);
  void clearName() => clearField(2);

  $1.Timestamp get time => $_getN(2);
  set time($1.Timestamp v) {
    setField(3, v);
  }

  $core.bool hasTime() => $_has(2);
  void clearTime() => clearField(3);

  $core.int get priority => $_get(3, 0);
  set priority($core.int v) {
    $_setSignedInt32(3, v);
  }

  $core.bool hasPriority() => $_has(3);
  void clearPriority() => clearField(4);

  ObjectValue get attributes => $_getN(4);
  set attributes(ObjectValue v) {
    setField(5, v);
  }

  $core.bool hasAttributes() => $_has(4);
  void clearAttributes() => clearField(5);
}

class RequestHeader extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('RequestHeader',
      package: const $pb.PackageName('org.openksavi.sponge.grpcapi'))
    ..aOS(1, 'id')
    ..aOS(2, 'username')
    ..aOS(3, 'password')
    ..aOS(4, 'authToken')
    ..hasRequiredFields = false;

  RequestHeader() : super();
  RequestHeader.fromBuffer($core.List<$core.int> i,
      [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  RequestHeader.fromJson($core.String i,
      [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  RequestHeader clone() => RequestHeader()..mergeFromMessage(this);
  RequestHeader copyWith(void Function(RequestHeader) updates) =>
      super.copyWith((message) => updates(message as RequestHeader));
  $pb.BuilderInfo get info_ => _i;
  static RequestHeader create() => RequestHeader();
  RequestHeader createEmptyInstance() => create();
  static $pb.PbList<RequestHeader> createRepeated() =>
      $pb.PbList<RequestHeader>();
  static RequestHeader getDefault() => _defaultInstance ??= create()..freeze();
  static RequestHeader _defaultInstance;

  $core.String get id => $_getS(0, '');
  set id($core.String v) {
    $_setString(0, v);
  }

  $core.bool hasId() => $_has(0);
  void clearId() => clearField(1);

  $core.String get username => $_getS(1, '');
  set username($core.String v) {
    $_setString(1, v);
  }

  $core.bool hasUsername() => $_has(1);
  void clearUsername() => clearField(2);

  $core.String get password => $_getS(2, '');
  set password($core.String v) {
    $_setString(2, v);
  }

  $core.bool hasPassword() => $_has(2);
  void clearPassword() => clearField(3);

  $core.String get authToken => $_getS(3, '');
  set authToken($core.String v) {
    $_setString(3, v);
  }

  $core.bool hasAuthToken() => $_has(3);
  void clearAuthToken() => clearField(4);
}

class ResponseHeader extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ResponseHeader',
      package: const $pb.PackageName('org.openksavi.sponge.grpcapi'))
    ..aOS(1, 'id')
    ..aOS(2, 'errorCode')
    ..aOS(3, 'errorMessage')
    ..aOS(4, 'detailedErrorMessage')
    ..hasRequiredFields = false;

  ResponseHeader() : super();
  ResponseHeader.fromBuffer($core.List<$core.int> i,
      [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  ResponseHeader.fromJson($core.String i,
      [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  ResponseHeader clone() => ResponseHeader()..mergeFromMessage(this);
  ResponseHeader copyWith(void Function(ResponseHeader) updates) =>
      super.copyWith((message) => updates(message as ResponseHeader));
  $pb.BuilderInfo get info_ => _i;
  static ResponseHeader create() => ResponseHeader();
  ResponseHeader createEmptyInstance() => create();
  static $pb.PbList<ResponseHeader> createRepeated() =>
      $pb.PbList<ResponseHeader>();
  static ResponseHeader getDefault() => _defaultInstance ??= create()..freeze();
  static ResponseHeader _defaultInstance;

  $core.String get id => $_getS(0, '');
  set id($core.String v) {
    $_setString(0, v);
  }

  $core.bool hasId() => $_has(0);
  void clearId() => clearField(1);

  $core.String get errorCode => $_getS(1, '');
  set errorCode($core.String v) {
    $_setString(1, v);
  }

  $core.bool hasErrorCode() => $_has(1);
  void clearErrorCode() => clearField(2);

  $core.String get errorMessage => $_getS(2, '');
  set errorMessage($core.String v) {
    $_setString(2, v);
  }

  $core.bool hasErrorMessage() => $_has(2);
  void clearErrorMessage() => clearField(3);

  $core.String get detailedErrorMessage => $_getS(3, '');
  set detailedErrorMessage($core.String v) {
    $_setString(3, v);
  }

  $core.bool hasDetailedErrorMessage() => $_has(3);
  void clearDetailedErrorMessage() => clearField(4);
}

class VersionRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('VersionRequest',
      package: const $pb.PackageName('org.openksavi.sponge.grpcapi'))
    ..a<RequestHeader>(1, 'header', $pb.PbFieldType.OM,
        RequestHeader.getDefault, RequestHeader.create)
    ..hasRequiredFields = false;

  VersionRequest() : super();
  VersionRequest.fromBuffer($core.List<$core.int> i,
      [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  VersionRequest.fromJson($core.String i,
      [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  VersionRequest clone() => VersionRequest()..mergeFromMessage(this);
  VersionRequest copyWith(void Function(VersionRequest) updates) =>
      super.copyWith((message) => updates(message as VersionRequest));
  $pb.BuilderInfo get info_ => _i;
  static VersionRequest create() => VersionRequest();
  VersionRequest createEmptyInstance() => create();
  static $pb.PbList<VersionRequest> createRepeated() =>
      $pb.PbList<VersionRequest>();
  static VersionRequest getDefault() => _defaultInstance ??= create()..freeze();
  static VersionRequest _defaultInstance;

  RequestHeader get header => $_getN(0);
  set header(RequestHeader v) {
    setField(1, v);
  }

  $core.bool hasHeader() => $_has(0);
  void clearHeader() => clearField(1);
}

class VersionResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('VersionResponse',
      package: const $pb.PackageName('org.openksavi.sponge.grpcapi'))
    ..a<ResponseHeader>(1, 'header', $pb.PbFieldType.OM,
        ResponseHeader.getDefault, ResponseHeader.create)
    ..aOS(2, 'version')
    ..hasRequiredFields = false;

  VersionResponse() : super();
  VersionResponse.fromBuffer($core.List<$core.int> i,
      [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  VersionResponse.fromJson($core.String i,
      [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  VersionResponse clone() => VersionResponse()..mergeFromMessage(this);
  VersionResponse copyWith(void Function(VersionResponse) updates) =>
      super.copyWith((message) => updates(message as VersionResponse));
  $pb.BuilderInfo get info_ => _i;
  static VersionResponse create() => VersionResponse();
  VersionResponse createEmptyInstance() => create();
  static $pb.PbList<VersionResponse> createRepeated() =>
      $pb.PbList<VersionResponse>();
  static VersionResponse getDefault() =>
      _defaultInstance ??= create()..freeze();
  static VersionResponse _defaultInstance;

  ResponseHeader get header => $_getN(0);
  set header(ResponseHeader v) {
    setField(1, v);
  }

  $core.bool hasHeader() => $_has(0);
  void clearHeader() => clearField(1);

  $core.String get version => $_getS(1, '');
  set version($core.String v) {
    $_setString(1, v);
  }

  $core.bool hasVersion() => $_has(1);
  void clearVersion() => clearField(2);
}

class SubscribeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('SubscribeRequest',
      package: const $pb.PackageName('org.openksavi.sponge.grpcapi'))
    ..a<RequestHeader>(1, 'header', $pb.PbFieldType.OM,
        RequestHeader.getDefault, RequestHeader.create)
    ..pPS(2, 'eventNames')
    ..hasRequiredFields = false;

  SubscribeRequest() : super();
  SubscribeRequest.fromBuffer($core.List<$core.int> i,
      [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  SubscribeRequest.fromJson($core.String i,
      [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  SubscribeRequest clone() => SubscribeRequest()..mergeFromMessage(this);
  SubscribeRequest copyWith(void Function(SubscribeRequest) updates) =>
      super.copyWith((message) => updates(message as SubscribeRequest));
  $pb.BuilderInfo get info_ => _i;
  static SubscribeRequest create() => SubscribeRequest();
  SubscribeRequest createEmptyInstance() => create();
  static $pb.PbList<SubscribeRequest> createRepeated() =>
      $pb.PbList<SubscribeRequest>();
  static SubscribeRequest getDefault() =>
      _defaultInstance ??= create()..freeze();
  static SubscribeRequest _defaultInstance;

  RequestHeader get header => $_getN(0);
  set header(RequestHeader v) {
    setField(1, v);
  }

  $core.bool hasHeader() => $_has(0);
  void clearHeader() => clearField(1);

  $core.List<$core.String> get eventNames => $_getList(1);
}

class SubscribeResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('SubscribeResponse',
      package: const $pb.PackageName('org.openksavi.sponge.grpcapi'))
    ..a<ResponseHeader>(1, 'header', $pb.PbFieldType.OM,
        ResponseHeader.getDefault, ResponseHeader.create)
    ..aInt64(2, 'subscriptionId')
    ..a<Event>(3, 'event', $pb.PbFieldType.OM, Event.getDefault, Event.create)
    ..hasRequiredFields = false;

  SubscribeResponse() : super();
  SubscribeResponse.fromBuffer($core.List<$core.int> i,
      [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY])
      : super.fromBuffer(i, r);
  SubscribeResponse.fromJson($core.String i,
      [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);
  SubscribeResponse clone() => SubscribeResponse()..mergeFromMessage(this);
  SubscribeResponse copyWith(void Function(SubscribeResponse) updates) =>
      super.copyWith((message) => updates(message as SubscribeResponse));
  $pb.BuilderInfo get info_ => _i;
  static SubscribeResponse create() => SubscribeResponse();
  SubscribeResponse createEmptyInstance() => create();
  static $pb.PbList<SubscribeResponse> createRepeated() =>
      $pb.PbList<SubscribeResponse>();
  static SubscribeResponse getDefault() =>
      _defaultInstance ??= create()..freeze();
  static SubscribeResponse _defaultInstance;

  ResponseHeader get header => $_getN(0);
  set header(ResponseHeader v) {
    setField(1, v);
  }

  $core.bool hasHeader() => $_has(0);
  void clearHeader() => clearField(1);

  Int64 get subscriptionId => $_getI64(1);
  set subscriptionId(Int64 v) {
    $_setInt64(1, v);
  }

  $core.bool hasSubscriptionId() => $_has(1);
  void clearSubscriptionId() => clearField(2);

  Event get event => $_getN(2);
  set event(Event v) {
    setField(3, v);
  }

  $core.bool hasEvent() => $_has(2);
  void clearEvent() => clearField(3);
}
