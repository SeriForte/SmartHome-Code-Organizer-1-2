import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sembast/sembast.dart';
import 'package:smart_home_code_organizer/classes/room_class.dart';
import 'package:smart_home_code_organizer/services/sembast_service.dart';

part 'room_provider.g.dart';

final List<Room> basicRooms = [
  const Room(name: 'Flur'),
  const Room(name: 'Küche'),
  const Room(name: 'Wohnzimmer'),
  const Room(name: 'Büro'),
  const Room(name: 'Gästezimmer'),
  const Room(name: 'Schlafzimmer'),
  const Room(name: 'Badezimmer'),
  const Room(name: 'Gästebad'),
  const Room(name: 'Abstellraum'),
  const Room(name: 'Heizungsraum'),
  const Room(name: 'Vorratsraum'),
];

@riverpod
class RoomList extends _$RoomList {
  @override
  FutureOr<List<Room>> build() async {
    state = const AsyncLoading();
    List<Room> roomList = [];
    final Database db = await SembastApi.connect();
    final data = await SembastApi.getData(
      db: db,
      storeName: SembastApi.roomStore,
    );

    for (var element in data) {
      roomList.add(Room.fromJson(element.value));
    }
    state = AsyncData(roomList);
    return roomList;
  }

  Future<void> addBasicRoom() async {
    /// only adds the basic values. if called again, it updates it int the Sembast process
    final Database db = await SembastApi.connect();

    for (var f in basicRooms) {
      SembastApi.addOrUpdateData(
          db: db,
          storeName: SembastApi.roomStore,
          uniqueFilter: SembastApi.roomUniqueFilter,
          map: f.toJson());
    }
    // Once the post request is done, we can mark the local cache as dirty.
    // This will cause "build" on our notifier to asynchronously be called again,
    // and will notify listeners when doing so.
    ref.invalidateSelf();

    await refresh();
  }

  Future<void> addRoom(Room room) async {
    final Database db = await SembastApi.connect();
    await SembastApi.addOrUpdateData(
        db: db,
        storeName: SembastApi.roomStore,
        uniqueFilter: SembastApi.roomUniqueFilter,
        map: room.toJson());
    // Once the post request is done, we can mark the local cache as dirty.
    // This will cause "build" on our notifier to asynchronously be called again,
    // and will notify listeners when doing so.
    ref.invalidateSelf();

    await refresh();
  }

  FutureOr<void> refresh() async {
    state = const AsyncLoading();
    List<Room> roomList = [];
    final Database db = await SembastApi.connect();
    final data = await SembastApi.getData(
      db: db,
      storeName: SembastApi.roomStore,
    );

    for (var element in data) {
      roomList.add(Room.fromJson(element.value));
    }
    state = AsyncData(roomList);
  }

  Future<void> deleteRoom(Room room) async {
    final Database db = await SembastApi.connect();

    await SembastApi.deleteData(
        db: db,
        storeName: SembastApi.roomStore,
        uniqueFilter: SembastApi.roomUniqueFilter,
        uniqueIdentifier: room.name);

    // Once the post request is done, we can mark the local cache as dirty.
    // This will cause "build" on our notifier to asynchronously be called again,
    // and will notify listeners when doing so.
    ref.invalidateSelf();

    await refresh();
  }
}




@riverpod
class RoomFilter extends _$RoomFilter {
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
