// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_type_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$deviceTypeListHash() => r'6b3ca579a6cc7d4295ca0508027a5049e6078b87';

/// See also [DeviceTypeList].
@ProviderFor(DeviceTypeList)
final deviceTypeListProvider =
    AutoDisposeAsyncNotifierProvider<DeviceTypeList, List<DeviceType>>.internal(
  DeviceTypeList.new,
  name: r'deviceTypeListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$deviceTypeListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DeviceTypeList = AutoDisposeAsyncNotifier<List<DeviceType>>;
String _$deviceTypeFilterHash() => r'b2e65a63ea604c7ba2b5032124d8a7244ac8e9e8';

/// See also [DeviceTypeFilter].
@ProviderFor(DeviceTypeFilter)
final deviceTypeFilterProvider =
    AutoDisposeNotifierProvider<DeviceTypeFilter, List<String>>.internal(
  DeviceTypeFilter.new,
  name: r'deviceTypeFilterProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$deviceTypeFilterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DeviceTypeFilter = AutoDisposeNotifier<List<String>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
