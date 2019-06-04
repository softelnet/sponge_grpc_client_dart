///
//  Generated code. Do not modify.
//  source: sponge.proto
///
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name

const ObjectValue$json = const {
  '1': 'ObjectValue',
  '2': const [
    const {
      '1': 'value_json',
      '3': 1,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'valueJson'
    },
    const {
      '1': 'value_any',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Any',
      '9': 0,
      '10': 'valueAny'
    },
  ],
  '8': const [
    const {'1': 'value_oneof'},
  ],
};

const Event$json = const {
  '1': 'Event',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {
      '1': 'time',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'time'
    },
    const {'1': 'priority', '3': 4, '4': 1, '5': 5, '10': 'priority'},
    const {'1': 'label', '3': 5, '4': 1, '5': 9, '10': 'label'},
    const {'1': 'description', '3': 6, '4': 1, '5': 9, '10': 'description'},
    const {
      '1': 'attributes',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.org.openksavi.sponge.grpcapi.ObjectValue',
      '10': 'attributes'
    },
  ],
};

const RequestHeader$json = const {
  '1': 'RequestHeader',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'username', '3': 2, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'password', '3': 3, '4': 1, '5': 9, '10': 'password'},
    const {'1': 'auth_token', '3': 4, '4': 1, '5': 9, '10': 'authToken'},
  ],
};

const ResponseHeader$json = const {
  '1': 'ResponseHeader',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'error_code', '3': 2, '4': 1, '5': 9, '10': 'errorCode'},
    const {'1': 'error_message', '3': 3, '4': 1, '5': 9, '10': 'errorMessage'},
    const {
      '1': 'detailed_error_message',
      '3': 4,
      '4': 1,
      '5': 9,
      '10': 'detailedErrorMessage'
    },
  ],
};

const VersionRequest$json = const {
  '1': 'VersionRequest',
  '2': const [
    const {
      '1': 'header',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.org.openksavi.sponge.grpcapi.RequestHeader',
      '10': 'header'
    },
  ],
};

const VersionResponse$json = const {
  '1': 'VersionResponse',
  '2': const [
    const {
      '1': 'header',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.org.openksavi.sponge.grpcapi.ResponseHeader',
      '10': 'header'
    },
    const {'1': 'version', '3': 2, '4': 1, '5': 9, '10': 'version'},
  ],
};

const SubscribeRequest$json = const {
  '1': 'SubscribeRequest',
  '2': const [
    const {
      '1': 'header',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.org.openksavi.sponge.grpcapi.RequestHeader',
      '10': 'header'
    },
    const {'1': 'event_names', '3': 2, '4': 3, '5': 9, '10': 'eventNames'},
  ],
};

const SubscribeResponse$json = const {
  '1': 'SubscribeResponse',
  '2': const [
    const {
      '1': 'header',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.org.openksavi.sponge.grpcapi.ResponseHeader',
      '10': 'header'
    },
    const {
      '1': 'subscription_id',
      '3': 2,
      '4': 1,
      '5': 3,
      '10': 'subscriptionId'
    },
    const {
      '1': 'event',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.org.openksavi.sponge.grpcapi.Event',
      '10': 'event'
    },
  ],
};
