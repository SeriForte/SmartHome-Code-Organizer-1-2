import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sembast/sembast.dart';
import 'package:smart_home_code_organizer/classes/floor_class.dart';
import 'package:smart_home_code_organizer/services/sembast_service.dart';

part 'floor_provider.g.dart';

final List<Floor> basicFloors = [
  const Floor(name: 'EG'),
  const Floor(name: 'UG'),
  const Floor(name: 'UG 1'),
  const Floor(name: 'UG 2'),
  const Floor(name: 'OG 1'),
  const Floor(name: 'OG 2'),
  const Floor(name: 'OG 3'),
  const Floor(name: 'Dachboden'),
];

@riverpod
class FloorList extends _$FloorList {
  @override
  FutureOr<List<Floor>> build() async {
    debugPrint('build Command of Floor List Provider');
    state = const AsyncLoading();
    List<Floor> floorList = [];
    final Database db = await SembastApi.connect();
    final data = await SembastApi.getData(
      db: db,
      storeName: SembastApi.floorStore,
    );

    for (var element in data) {
      floorList.add(Floor.fromJson(element.value));
    }
    state = AsyncData(floorList);

    return floorList;
  }

  Future<void> addBasicFloors() async {
    /// only adds the basic values. if called again, it updates it int the Sembast process
    final Database db = await SembastApi.connect();

    for (var f in basicFloors) {
      SembastApi.addOrUpdateData(
          db: db,
          storeName: SembastApi.floorStore,
          uniqueFilter: SembastApi.floorUniqueFilter,
          map: f.toJson());
    }
    // Once the post request is done, we can mark the local cache as dirty.
    // This will cause "build" on our notifier to asynchronously be called again,
    // and will notify listeners when doing so.
    ref.invalidateSelf();

    await refresh();
  }

  Future<void> addFloor(Floor floor) async {
    final Database db = await SembastApi.connect();
    await SembastApi.addOrUpdateData(
        db: db,
        storeName: SembastApi.floorStore,
        uniqueFilter: SembastApi.floorUniqueFilter,
        map: floor.toJson());
    // Once the post request is done, we can mark the local cache as dirty.
    // This will cause "build" on our notifier to asynchronously be called again,
    // and will notify listeners when doing so.
    ref.invalidateSelf();

    await refresh();
  }

  FutureOr<void> refresh() async {
    state = const AsyncLoading();
    List<Floor> floorList = [];
    final Database db = await SembastApi.connect();
    final data = await SembastApi.getData(
      db: db,
      storeName: SembastApi.floorStore,
    );

    for (var element in data) {
      floorList.add(Floor.fromJson(element.value));
    }
    state = AsyncData(floorList);
  }

  Future<void> deleteFloor(Floor floor) async {
    final Database db = await SembastApi.connect();

    await SembastApi.deleteData(
        db: db,
        storeName: SembastApi.floorStore,
        uniqueFilter: SembastApi.floorUniqueFilter,
        uniqueIdentifier: floor.name);

    // Once the post request is done, we can mark the local cache as dirty.
    // This will cause "build" on our notifier to asynchronously be called again,
    // and will notify listeners when doing so.
    ref.invalidateSelf();

    await refresh();
  }
}




@riverpod
class FloorFilter extends _$FloorFilter {
  @override
  List<String> build() {
    return [];
  }

  List<String> setList(List<String> nameList) {
    debugPrint('call setList with $nameList');
    debugPrint(state.toString());
    state = nameList;
    state = [...state];
    debugPrint(state.toString());
    return state;
  }

  void add(String name) {
    debugPrint('call Add with $name');
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
