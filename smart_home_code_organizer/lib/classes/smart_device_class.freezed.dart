// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'smart_device_class.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SmartDevice implements DiagnosticableTreeMixin {
  String get qrCode;
  String get deviceType;
  String get smartKey;
  String get sgtin;
  String get name;
  String get description;
  String get room;
  String get floor;
  String get building;
  int? get sembastKey;

  /// Create a copy of SmartDevice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SmartDeviceCopyWith<SmartDevice> get copyWith =>
      _$SmartDeviceCopyWithImpl<SmartDevice>(this as SmartDevice, _$identity);

  /// Serializes this SmartDevice to a JSON map.
  Map<String, dynamic> toJson();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'SmartDevice'))
      ..add(DiagnosticsProperty('qrCode', qrCode))
      ..add(DiagnosticsProperty('deviceType', deviceType))
      ..add(DiagnosticsProperty('smartKey', smartKey))
      ..add(DiagnosticsProperty('sgtin', sgtin))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('room', room))
      ..add(DiagnosticsProperty('floor', floor))
      ..add(DiagnosticsProperty('building', building))
      ..add(DiagnosticsProperty('sembastKey', sembastKey));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SmartDevice &&
            (identical(other.qrCode, qrCode) || other.qrCode == qrCode) &&
            (identical(other.deviceType, deviceType) ||
                other.deviceType == deviceType) &&
            (identical(other.smartKey, smartKey) ||
                other.smartKey == smartKey) &&
            (identical(other.sgtin, sgtin) || other.sgtin == sgtin) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.room, room) || other.room == room) &&
            (identical(other.floor, floor) || other.floor == floor) &&
            (identical(other.building, building) ||
                other.building == building) &&
            (identical(other.sembastKey, sembastKey) ||
                other.sembastKey == sembastKey));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, qrCode, deviceType, smartKey,
      sgtin, name, description, room, floor, building, sembastKey);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SmartDevice(qrCode: $qrCode, deviceType: $deviceType, smartKey: $smartKey, sgtin: $sgtin, name: $name, description: $description, room: $room, floor: $floor, building: $building, sembastKey: $sembastKey)';
  }
}

/// @nodoc
abstract mixin class $SmartDeviceCopyWith<$Res> {
  factory $SmartDeviceCopyWith(
          SmartDevice value, $Res Function(SmartDevice) _then) =
      _$SmartDeviceCopyWithImpl;
  @useResult
  $Res call(
      {String qrCode,
      String deviceType,
      String smartKey,
      String sgtin,
      String name,
      String description,
      String room,
      String floor,
      String building,
      int? sembastKey});
}

/// @nodoc
class _$SmartDeviceCopyWithImpl<$Res> implements $SmartDeviceCopyWith<$Res> {
  _$SmartDeviceCopyWithImpl(this._self, this._then);

  final SmartDevice _self;
  final $Res Function(SmartDevice) _then;

  /// Create a copy of SmartDevice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? qrCode = null,
    Object? deviceType = null,
    Object? smartKey = null,
    Object? sgtin = null,
    Object? name = null,
    Object? description = null,
    Object? room = null,
    Object? floor = null,
    Object? building = null,
    Object? sembastKey = freezed,
  }) {
    return _then(_self.copyWith(
      qrCode: null == qrCode
          ? _self.qrCode
          : qrCode // ignore: cast_nullable_to_non_nullable
              as String,
      deviceType: null == deviceType
          ? _self.deviceType
          : deviceType // ignore: cast_nullable_to_non_nullable
              as String,
      smartKey: null == smartKey
          ? _self.smartKey
          : smartKey // ignore: cast_nullable_to_non_nullable
              as String,
      sgtin: null == sgtin
          ? _self.sgtin
          : sgtin // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      room: null == room
          ? _self.room
          : room // ignore: cast_nullable_to_non_nullable
              as String,
      floor: null == floor
          ? _self.floor
          : floor // ignore: cast_nullable_to_non_nullable
              as String,
      building: null == building
          ? _self.building
          : building // ignore: cast_nullable_to_non_nullable
              as String,
      sembastKey: freezed == sembastKey
          ? _self.sembastKey
          : sembastKey // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _SmartDevice with DiagnosticableTreeMixin implements SmartDevice {
  const _SmartDevice(
      {this.qrCode = '-',
      this.deviceType = '-',
      this.smartKey = '-',
      this.sgtin = '-',
      this.name = '-',
      this.description = '-',
      this.room = '-',
      this.floor = '-',
      this.building = '-',
      this.sembastKey});
  factory _SmartDevice.fromJson(Map<String, dynamic> json) =>
      _$SmartDeviceFromJson(json);

  @override
  @JsonKey()
  final String qrCode;
  @override
  @JsonKey()
  final String deviceType;
  @override
  @JsonKey()
  final String smartKey;
  @override
  @JsonKey()
  final String sgtin;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final String room;
  @override
  @JsonKey()
  final String floor;
  @override
  @JsonKey()
  final String building;
  @override
  final int? sembastKey;

  /// Create a copy of SmartDevice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SmartDeviceCopyWith<_SmartDevice> get copyWith =>
      __$SmartDeviceCopyWithImpl<_SmartDevice>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SmartDeviceToJson(
      this,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'SmartDevice'))
      ..add(DiagnosticsProperty('qrCode', qrCode))
      ..add(DiagnosticsProperty('deviceType', deviceType))
      ..add(DiagnosticsProperty('smartKey', smartKey))
      ..add(DiagnosticsProperty('sgtin', sgtin))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('room', room))
      ..add(DiagnosticsProperty('floor', floor))
      ..add(DiagnosticsProperty('building', building))
      ..add(DiagnosticsProperty('sembastKey', sembastKey));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SmartDevice &&
            (identical(other.qrCode, qrCode) || other.qrCode == qrCode) &&
            (identical(other.deviceType, deviceType) ||
                other.deviceType == deviceType) &&
            (identical(other.smartKey, smartKey) ||
                other.smartKey == smartKey) &&
            (identical(other.sgtin, sgtin) || other.sgtin == sgtin) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.room, room) || other.room == room) &&
            (identical(other.floor, floor) || other.floor == floor) &&
            (identical(other.building, building) ||
                other.building == building) &&
            (identical(other.sembastKey, sembastKey) ||
                other.sembastKey == sembastKey));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, qrCode, deviceType, smartKey,
      sgtin, name, description, room, floor, building, sembastKey);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SmartDevice(qrCode: $qrCode, deviceType: $deviceType, smartKey: $smartKey, sgtin: $sgtin, name: $name, description: $description, room: $room, floor: $floor, building: $building, sembastKey: $sembastKey)';
  }
}

/// @nodoc
abstract mixin class _$SmartDeviceCopyWith<$Res>
    implements $SmartDeviceCopyWith<$Res> {
  factory _$SmartDeviceCopyWith(
          _SmartDevice value, $Res Function(_SmartDevice) _then) =
      __$SmartDeviceCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String qrCode,
      String deviceType,
      String smartKey,
      String sgtin,
      String name,
      String description,
      String room,
      String floor,
      String building,
      int? sembastKey});
}

/// @nodoc
class __$SmartDeviceCopyWithImpl<$Res> implements _$SmartDeviceCopyWith<$Res> {
  __$SmartDeviceCopyWithImpl(this._self, this._then);

  final _SmartDevice _self;
  final $Res Function(_SmartDevice) _then;

  /// Create a copy of SmartDevice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? qrCode = null,
    Object? deviceType = null,
    Object? smartKey = null,
    Object? sgtin = null,
    Object? name = null,
    Object? description = null,
    Object? room = null,
    Object? floor = null,
    Object? building = null,
    Object? sembastKey = freezed,
  }) {
    return _then(_SmartDevice(
      qrCode: null == qrCode
          ? _self.qrCode
          : qrCode // ignore: cast_nullable_to_non_nullable
              as String,
      deviceType: null == deviceType
          ? _self.deviceType
          : deviceType // ignore: cast_nullable_to_non_nullable
              as String,
      smartKey: null == smartKey
          ? _self.smartKey
          : smartKey // ignore: cast_nullable_to_non_nullable
              as String,
      sgtin: null == sgtin
          ? _self.sgtin
          : sgtin // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      room: null == room
          ? _self.room
          : room // ignore: cast_nullable_to_non_nullable
              as String,
      floor: null == floor
          ? _self.floor
          : floor // ignore: cast_nullable_to_non_nullable
              as String,
      building: null == building
          ? _self.building
          : building // ignore: cast_nullable_to_non_nullable
              as String,
      sembastKey: freezed == sembastKey
          ? _self.sembastKey
          : sembastKey // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

// dart format on
