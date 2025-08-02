import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sembast/sembast.dart';
import 'package:smart_home_code_organizer/classes/building_class.dart';

import 'package:smart_home_code_organizer/services/sembast_service.dart';

part 'building_provider.g.dart';

final List<Building> basicBuilding = [
  const Building(name: 'Mein Zuhause', isFavorite: true),
];

@riverpod
class BuildingList extends _$BuildingList {
  @override
  FutureOr<List<Building>> build() async {
    debugPrint('BuildingList build() Command of Building List Provider');
    state = const AsyncLoading();
    List<Building> buildingList = [];
    final Database db = await SembastApi.connect();
    final data = await SembastApi.getData(
      db: db,
      storeName: SembastApi.buildingStore,
    );

    for (var element in data) {
      buildingList.add(Building.fromJson(element.value));
    }
    state = AsyncData([...buildingList]);
    debugPrint('build() after call invalidateSelf State = ${state.toString()}');

    return buildingList;
  }

  Future<void> addBasicBuilding() async {
    /// only adds the basic values. if called again, it updates it int the Sembast process
    final Database db = await SembastApi.connect();

    for (var b in basicBuilding) {
      SembastApi.addOrUpdateData(
          db: db,
          storeName: SembastApi.buildingStore,
          uniqueFilter: SembastApi.buildingUniqueFilter,
          map: b.toJson());
    }
    // Once the post request is done, we can mark the local cache as dirty.
    // This will cause "build" on our notifier to asynchronously be called again,
    // and will notify listeners when doing so.
    ref.invalidateSelf();

    await refresh();
  }

  Future<void> addBuilding(Building building) async {
    final Database db = await SembastApi.connect();
    await SembastApi.addOrUpdateData(
        db: db,
        storeName: SembastApi.buildingStore,
        uniqueFilter: SembastApi.buildingUniqueFilter,
        map: building.toJson());
    // Once the post request is done, we can mark the local cache as dirty.
    // This will cause "build" on our notifier to asynchronously be called again,
    // and will notify listeners when doing so.
    ref.invalidateSelf();

    await refresh();
  }

  Future<void> toggleFavorit(Building building) async {
    final Database db = await SembastApi.connect();
    debugPrint('setFavorite = ${building.toString()}');

    await SembastApi.toogleBuildingFavorites(
        db: db, newFavorite: building.toJson());

    // Once the post request is done, we can mark the local cache as dirty.
    // This will cause "build" on our notifier to asynchronously be called again,
    // and will notify listeners when doing so.
    ref.invalidateSelf();

    // await refresh();
    debugPrint('setFavorite() after call refresh State = ${state.toString()}');
  }

  Future<void> setFavorite(Building building) async {
    final Database db = await SembastApi.connect();
    debugPrint('setFavorite = ${building.toString()}');

    await SembastApi.addOrUpdateData(
        db: db,
        storeName: SembastApi.buildingStore,
        uniqueFilter: SembastApi.buildingUniqueFilter,
        map: building.toJson());
    // Once the post request is done, we can mark the local cache as dirty.
    // This will cause "build" on our notifier to asynchronously be called again,
    // and will notify listeners when doing so.
    ref.invalidateSelf();

    // await refresh();
    debugPrint('setFavorite() after call refresh State = ${state.toString()}');
  }

  FutureOr<void> refresh() async {
    debugPrint('refresh() building');
    state = const AsyncLoading();
    List<Building> buildingList = [];
    final Database db = await SembastApi.connect();
    final data = await SembastApi.getData(
      db: db,
      storeName: SembastApi.buildingStore,
    );

    for (var element in data) {
      buildingList.add(Building.fromJson(element.value));
      debugPrint('buildingList of Refresh() ${element.toString()}');
    }
    state = AsyncData([...buildingList]);
    debugPrint('state of Refresh() ${state.toString()}');
  }

  Future<void> deleteBuilding(Building building) async {
    final Database db = await SembastApi.connect();

    await SembastApi.deleteData(
        db: db,
        storeName: SembastApi.buildingStore,
        uniqueFilter: SembastApi.buildingUniqueFilter,
        uniqueIdentifier: building.name);

    // Once the post request is done, we can mark the local cache as dirty.
    // This will cause "build" on our notifier to asynchronously be called again,
    // and will notify listeners when doing so.
    ref.invalidateSelf();

    await refresh();
  }
}

@riverpod
class BuildingFilter extends _$BuildingFilter {
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
