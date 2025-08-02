// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$floorListHash() => r'4e617433421aa1d4667c0c12b82353dde0b1a42e';

/// See also [FloorList].
@ProviderFor(FloorList)
final floorListProvider =
    AutoDisposeAsyncNotifierProvider<FloorList, List<Floor>>.internal(
  FloorList.new,
  name: r'floorListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$floorListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FloorList = AutoDisposeAsyncNotifier<List<Floor>>;
String _$floorFilterHash() => r'8975cf19bc5c375e66963a347c4d97402d28f39f';

/// See also [FloorFilter].
@ProviderFor(FloorFilter)
final floorFilterProvider =
    AutoDisposeNotifierProvider<FloorFilter, List<String>>.internal(
  FloorFilter.new,
  name: r'floorFilterProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$floorFilterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FloorFilter = AutoDisposeNotifier<List<String>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
