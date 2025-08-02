// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'building_class.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Building {
  String get name;
  bool get isFavorite;

  /// Create a copy of Building
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BuildingCopyWith<Building> get copyWith =>
      _$BuildingCopyWithImpl<Building>(this as Building, _$identity);

  /// Serializes this Building to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Building &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, isFavorite);

  @override
  String toString() {
    return 'Building(name: $name, isFavorite: $isFavorite)';
  }
}

/// @nodoc
abstract mixin class $BuildingCopyWith<$Res> {
  factory $BuildingCopyWith(Building value, $Res Function(Building) _then) =
      _$BuildingCopyWithImpl;
  @useResult
  $Res call({String name, bool isFavorite});
}

/// @nodoc
class _$BuildingCopyWithImpl<$Res> implements $BuildingCopyWith<$Res> {
  _$BuildingCopyWithImpl(this._self, this._then);

  final Building _self;
  final $Res Function(Building) _then;

  /// Create a copy of Building
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? isFavorite = null,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isFavorite: null == isFavorite
          ? _self.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Building implements Building {
  const _Building({this.name = '-', this.isFavorite = false});
  factory _Building.fromJson(Map<String, dynamic> json) =>
      _$BuildingFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final bool isFavorite;

  /// Create a copy of Building
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BuildingCopyWith<_Building> get copyWith =>
      __$BuildingCopyWithImpl<_Building>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BuildingToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Building &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, isFavorite);

  @override
  String toString() {
    return 'Building(name: $name, isFavorite: $isFavorite)';
  }
}

/// @nodoc
abstract mixin class _$BuildingCopyWith<$Res>
    implements $BuildingCopyWith<$Res> {
  factory _$BuildingCopyWith(_Building value, $Res Function(_Building) _then) =
      __$BuildingCopyWithImpl;
  @override
  @useResult
  $Res call({String name, bool isFavorite});
}

/// @nodoc
class __$BuildingCopyWithImpl<$Res> implements _$BuildingCopyWith<$Res> {
  __$BuildingCopyWithImpl(this._self, this._then);

  final _Building _self;
  final $Res Function(_Building) _then;

  /// Create a copy of Building
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? isFavorite = null,
  }) {
    return _then(_Building(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isFavorite: null == isFavorite
          ? _self.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
