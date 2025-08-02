import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sembast/sembast.dart';
import 'package:smart_home_code_organizer/classes/device_type_class.dart';
import 'package:smart_home_code_organizer/services/sembast_service.dart';

part 'device_type_provider.g.dart';

final Set<DeviceType> basicTypes = {
  const DeviceType(
      name: 'HmIP-BROLL-2',
      descripton: 'HomematicIP Rolladenaktor für Markenschalter'),
  const DeviceType(
      name: 'HmIP-WTH-2',
      descripton: 'HomematicIP Wandthermostat mit Luftfeuchtigkeitssensor'),
  const DeviceType(
      name: 'HmIP-FROLL', descripton: 'HomematicIP Rolladenaktor Unterputz'),
};

@riverpod
class DeviceTypeList extends _$DeviceTypeList {
  @override
  FutureOr<List<DeviceType>> build() async {
    // debugPrint('DeviceTypeList build() ');
    state = const AsyncLoading();
    List<DeviceType> deviceTypeList = [];
    final Database db = await SembastApi.connect();
    final data = await SembastApi.getData(
      db: db,
      storeName: SembastApi.typeStore,
    );

    for (var element in data) {
      deviceTypeList.add(DeviceType.fromJson(element.value));
    }
    // debugPrint('DeviceTypeList state=  ${deviceTypeList.toString()}');
    state = AsyncData(deviceTypeList);
    return deviceTypeList;
  }

  Future<void> addBasicTypes() async {
    /// only adds the basic values. if called again, it updates it int the Sembast process
    final Database db = await SembastApi.connect();

    for (var t in basicTypes) {
      await SembastApi.addOrUpdateData(
          db: db,
          storeName: SembastApi.typeStore,
          uniqueFilter: SembastApi.typeUniqueFilter,
          map: t.toJson());
    }
    // Once the post request is done, we can mark the local cache as dirty.
    // This will cause "build" on our notifier to asynchronously be called again,
    // and will notify listeners when doing so.
    ref.invalidateSelf();

    await refresh();
  }

  Future<void> addDeviceType(DeviceType type) async {
    final Database db = await SembastApi.connect();
    await SembastApi.addOrUpdateData(
        db: db,
        storeName: SembastApi.typeStore,
        uniqueFilter: SembastApi.typeUniqueFilter,
        map: type.toJson());
    // Once the post request is done, we can mark the local cache as dirty.
    // This will cause "build" on our notifier to asynchronously be called again,
    // and will notify listeners when doing so.
    ref.invalidateSelf();

    await refresh();
  }

  FutureOr<void> refresh() async {
    state = const AsyncLoading();
    List<DeviceType> deviceTypeList = [];

    final Database db = await SembastApi.connect();
    final data = await SembastApi.getData(
      db: db,
      storeName: SembastApi.typeStore,
    );

    for (var element in data) {
      deviceTypeList.add(DeviceType.fromJson(element.value));
    }
    state = AsyncData(deviceTypeList);
  }

  Future<void> deleteDeviceType(DeviceType type) async {
    final Database db = await SembastApi.connect();

    await SembastApi.deleteData(
        db: db,
        storeName: SembastApi.typeStore,
        uniqueFilter: SembastApi.typeUniqueFilter,
        uniqueIdentifier: type.name);

    // Once the post request is done, we can mark the local cache as dirty.
    // This will cause "build" on our notifier to asynchronously be called again,
    // and will notify listeners when doing so.
    ref.invalidateSelf();

    await refresh();
  }
}

@riverpod
class DeviceTypeFilter extends _$DeviceTypeFilter {
  @override
  List<String> build() {
    // debugPrint('build TypeFilter');
    return [];
  }

  List<String> setList(List<String> nameList) {
    debugPrint('DeviceTypeFilter call setList with $nameList');
    debugPrint(state.toString());
    state = nameList;
    state = [...state];
    debugPrint(state.toString());
    return state;
  }

  void add(String name) {
    debugPrint('DeviceTypeFilter call Add with $name');
    debugPrint(state.toString());

    if (!state.contains(name)) {
      state.add(name);
    }
  }

  void remove(String name) {
    if (state.contains(name)) {
      state.remove(name);
    }
  }
}
