// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smart_device_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sgtinNummersHash() => r'4769b7f53f3b2452b729a462702325477ff4001c';

/// See also [sgtinNummers].
@ProviderFor(sgtinNummers)
final sgtinNummersProvider = AutoDisposeFutureProvider<List<String>>.internal(
  sgtinNummers,
  name: r'sgtinNummersProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$sgtinNummersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SgtinNummersRef = AutoDisposeFutureProviderRef<List<String>>;
String _$smartDeviceListHash() => r'a40365ea543b50179a611d5aa74792919addaf56';

/// See also [SmartDeviceList].
@ProviderFor(SmartDeviceList)
final smartDeviceListProvider = AutoDisposeAsyncNotifierProvider<
    SmartDeviceList, List<SmartDevice>>.internal(
  SmartDeviceList.new,
  name: r'smartDeviceListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$smartDeviceListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SmartDeviceList = AutoDisposeAsyncNotifier<List<SmartDevice>>;
String _$smartDeviceFocusHash() => r'11e03485b906232c53b826ac5008da5f7b367034';

/// See also [SmartDeviceFocus].
@ProviderFor(SmartDeviceFocus)
final smartDeviceFocusProvider =
    NotifierProvider<SmartDeviceFocus, SmartDevice?>.internal(
  SmartDeviceFocus.new,
  name: r'smartDeviceFocusProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$smartDeviceFocusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SmartDeviceFocus = Notifier<SmartDevice?>;
String _$smartDeviceFilterListHash() =>
    r'e14c80182f34323c7a81591c91fc5f7e3ff6cb8c';

/// See also [SmartDeviceFilterList].
@ProviderFor(SmartDeviceFilterList)
final smartDeviceFilterListProvider =
    AsyncNotifierProvider<SmartDeviceFilterList, List<SmartDevice>>.internal(
  SmartDeviceFilterList.new,
  name: r'smartDeviceFilterListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$smartDeviceFilterListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SmartDeviceFilterList = AsyncNotifier<List<SmartDevice>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
