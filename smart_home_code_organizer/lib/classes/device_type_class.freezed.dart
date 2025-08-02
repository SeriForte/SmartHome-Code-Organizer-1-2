// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_type_class.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DeviceType implements DiagnosticableTreeMixin {
  String get name;
  String get descripton;

  /// Create a copy of DeviceType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DeviceTypeCopyWith<DeviceType> get copyWith =>
      _$DeviceTypeCopyWithImpl<DeviceType>(this as DeviceType, _$identity);

  /// Serializes this DeviceType to a JSON map.
  Map<String, dynamic> toJson();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'DeviceType'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('descripton', descripton));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DeviceType &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.descripton, descripton) ||
                other.descripton == descripton));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, descripton);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DeviceType(name: $name, descripton: $descripton)';
  }
}

/// @nodoc
abstract mixin class $DeviceTypeCopyWith<$Res> {
  factory $DeviceTypeCopyWith(
          DeviceType value, $Res Function(DeviceType) _then) =
      _$DeviceTypeCopyWithImpl;
  @useResult
  $Res call({String name, String descripton});
}

/// @nodoc
class _$DeviceTypeCopyWithImpl<$Res> implements $DeviceTypeCopyWith<$Res> {
  _$DeviceTypeCopyWithImpl(this._self, this._then);

  final DeviceType _self;
  final $Res Function(DeviceType) _then;

  /// Create a copy of DeviceType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? descripton = null,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      descripton: null == descripton
          ? _self.descripton
          : descripton // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _DeviceType with DiagnosticableTreeMixin implements DeviceType {
  const _DeviceType({this.name = '-', this.descripton = '-'});
  factory _DeviceType.fromJson(Map<String, dynamic> json) =>
      _$DeviceTypeFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String descripton;

  /// Create a copy of DeviceType
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DeviceTypeCopyWith<_DeviceType> get copyWith =>
      __$DeviceTypeCopyWithImpl<_DeviceType>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DeviceTypeToJson(
      this,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'DeviceType'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('descripton', descripton));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DeviceType &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.descripton, descripton) ||
                other.descripton == descripton));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, descripton);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DeviceType(name: $name, descripton: $descripton)';
  }
}

/// @nodoc
abstract mixin class _$DeviceTypeCopyWith<$Res>
    implements $DeviceTypeCopyWith<$Res> {
  factory _$DeviceTypeCopyWith(
          _DeviceType value, $Res Function(_DeviceType) _then) =
      __$DeviceTypeCopyWithImpl;
  @override
  @useResult
  $Res call({String name, String descripton});
}

/// @nodoc
class __$DeviceTypeCopyWithImpl<$Res> implements _$DeviceTypeCopyWith<$Res> {
  __$DeviceTypeCopyWithImpl(this._self, this._then);

  final _DeviceType _self;
  final $Res Function(_DeviceType) _then;

  /// Create a copy of DeviceType
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? descripton = null,
  }) {
    return _then(_DeviceType(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      descripton: null == descripton
          ? _self.descripton
          : descripton // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
