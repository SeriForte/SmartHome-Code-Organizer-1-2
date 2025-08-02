// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$roomListHash() => r'6047ddb6bb3ccc5dfa59638374c8549a20cdd0e5';

/// See also [RoomList].
@ProviderFor(RoomList)
final roomListProvider =
    AutoDisposeAsyncNotifierProvider<RoomList, List<Room>>.internal(
  RoomList.new,
  name: r'roomListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$roomListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RoomList = AutoDisposeAsyncNotifier<List<Room>>;
String _$roomFilterHash() => r'561351985c8e03b18a2bebfa24b5256fba26b2ec';

/// See also [RoomFilter].
@ProviderFor(RoomFilter)
final roomFilterProvider =
    AutoDisposeNotifierProvider<RoomFilter, List<String>>.internal(
  RoomFilter.new,
  name: r'roomFilterProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$roomFilterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RoomFilter = AutoDisposeNotifier<List<String>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
