#!/bin/bash

protoc --dart_out=grpc:lib/src/generated -Iprotos protos/sponge.proto google/protobuf/timestamp.proto google/protobuf/any.proto

dartfmt -w lib/src/generated
