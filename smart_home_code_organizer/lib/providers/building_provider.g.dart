// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'building_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$buildingListHash() => r'0bcfcdf55eabf625377994eb5aa643142ec40cbf';

/// See also [BuildingList].
@ProviderFor(BuildingList)
final buildingListProvider =
    AutoDisposeAsyncNotifierProvider<BuildingList, List<Building>>.internal(
  BuildingList.new,
  name: r'buildingListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$buildingListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$BuildingList = AutoDisposeAsyncNotifier<List<Building>>;
String _$buildingFilterHash() => r'7e86abf7a98da332e8682b4a4ee322095c907dfb';

/// See also [BuildingFilter].
@ProviderFor(BuildingFilter)
final buildingFilterProvider =
    AutoDisposeNotifierProvider<BuildingFilter, List<String>>.internal(
  BuildingFilter.new,
  name: r'buildingFilterProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$buildingFilterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$BuildingFilter = AutoDisposeNotifier<List<String>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
