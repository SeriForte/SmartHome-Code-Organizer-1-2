import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sembast/sembast.dart';
import 'package:smart_home_code_organizer/classes/smart_device_class.dart';
import 'package:smart_home_code_organizer/providers/device_type_provider.dart';
import 'package:smart_home_code_organizer/providers/floor_provider.dart';
import 'package:smart_home_code_organizer/providers/room_provider.dart';
import 'package:smart_home_code_organizer/services/sembast_service.dart';

part 'smart_device_provider.g.dart';

@riverpod
class SmartDeviceList extends _$SmartDeviceList {
  @override
  FutureOr<List<SmartDevice>> build() async {
    debugPrint('SmartDeviceList build()');
    // state = const AsyncLoading();
    state = const AsyncValue.loading();
    // debugPrint('state= $state');
    final Database db = await SembastApi.connect();
    List<SmartDevice> allSmartDevices = [];
    final data = await SembastApi.getAllSmartDevices(db);

    for (var element in data) {
      allSmartDevices.add(SmartDevice.fromJson(element));
    }
    state = AsyncData([...allSmartDevices]);
    // debugPrint('state= $state');
    // ref.notifyListeners();

    // refresh the filtered List
    ref.read(smartDeviceFilterListProvider.notifier).refresh();

    return allSmartDevices;
  }

  Future<void> addSmartDevice(SmartDevice smartDevice) async {
    final Database db = await SembastApi.connect();

    debugPrint('addSmartDevice()');
    debugPrint(smartDevice.toString());

    await SembastApi.addOrUpdateData(
        db: db,
        storeName: SembastApi.deviceStore,
        uniqueFilter: SembastApi.deviceUniqueFilter,
        map: smartDevice.toJson());
    // Once the post request is done, we can mark the local cache as dirty.
    // This will cause "build" on our notifier to asynchronously be called again,
    // and will notify listeners when doing so.
    ref.invalidateSelf();

    // await refresh();
  }

  FutureOr<void> refresh() async {
    state = const AsyncLoading();
    final Database db = await SembastApi.connect();

    List<SmartDevice> allSmartDevices = [];
    final data = await SembastApi.getAllSmartDevices(db);

    for (var element in data) {
      allSmartDevices.add(SmartDevice.fromJson(element));
    }
    state = AsyncData([...allSmartDevices]);
  }

  Future<void> deleteSmartDevice(SmartDevice smartDevice) async {
    final Database db = await SembastApi.connect();

    await SembastApi.deleteData(
        db: db,
        storeName: SembastApi.deviceStore,
        uniqueFilter: SembastApi.deviceUniqueFilter,
        uniqueIdentifier: smartDevice.sgtin);

    // Once the post request is done, we can mark the local cache as dirty.
    // This will cause "build" on our notifier to asynchronously be called again,
    // and will notify listeners when doing so.
    ref.invalidateSelf();

    // await refresh();
  }
}

@riverpod
FutureOr<List<String>> sgtinNummers(Ref ref) async {
  final Database db = await SembastApi.connect();
  debugPrint('Lade sgtinList ');
  List<String> sgtinList = await SembastApi.getAllSGTIN(db: db);
  debugPrint('sgtinList ist vorhanden');
  return sgtinList;
}

@Riverpod(keepAlive: true)
class SmartDeviceFocus extends _$SmartDeviceFocus {
  @override
  SmartDevice? build() {
    return null;
  }

  void setAllValues(SmartDevice newSmartDevice) {
    state = SmartDevice(
        qrCode: newSmartDevice.qrCode,
        deviceType: newSmartDevice.deviceType,
        smartKey: newSmartDevice.smartKey,
        sgtin: newSmartDevice.sgtin,
        name: newSmartDevice.name,
        description: newSmartDevice.description,
        room: newSmartDevice.room,
        floor: newSmartDevice.floor,
        building: newSmartDevice.building);
  }

  void resetAllValues() {
    state = null;
  }
}

@Riverpod(keepAlive: true)
class SmartDeviceFilterList extends _$SmartDeviceFilterList {
  @override
  FutureOr<List<SmartDevice>> build() async {
    state = const AsyncLoading();
    final Database db = await SembastApi.connect();
    List<SmartDevice> allSmartDevices = [];
    final data = await SembastApi.getAllSmartDevices(db);
    for (var element in data) {
      allSmartDevices.add(SmartDevice.fromJson(element));
    }
    state = AsyncData(allSmartDevices);
    return allSmartDevices;
  }

  FutureOr<void> refresh() async {
    state = const AsyncLoading();
    final Database db = await SembastApi.connect();

    List<SmartDevice> allSmartDevices = [];
    final data = await SembastApi.getAllSmartDevices(db);

    for (var element in data) {
      allSmartDevices.add(SmartDevice.fromJson(element));
    }
    state = AsyncData([...allSmartDevices]);
  }

  FutureOr<void> applyFilter() async {
    List<String> typeFilter = ref.read(deviceTypeFilterProvider);
    List<String> floorFilter = ref.read(floorFilterProvider);
    List<String> roomFilter = ref.read(roomFilterProvider);

    state = const AsyncLoading();
    final Database db = await SembastApi.connect();
    List<SmartDevice> data = await SembastApi.filterSmartDevice(
        db: db,
        typeList: typeFilter,
        floorList: floorFilter,
        roomList: roomFilter);
    state = AsyncData(data);
  }
}

// @riverpod
// class SmartDeviceList extends _$SmartDeviceList {
//   @override
//   Future<List<SmartDevice>> build() async {
//     return [];
//   }

//   Future<AsyncValue<List<SmartDevice>>> readDbList() async {
//     state = const AsyncLoading();
//     state = await AsyncValue.guard(SembastApi.readAllData);
//     return state;
//   }

//   void clearList() {
//     List<SmartDevice> clearList = [];
//     state = const AsyncLoading();
//     state = AsyncValue.data(clearList);
//   }
// }


// @riverpod
// class SmartDeviceList extends _$SmartDeviceList {
//   @override
//   Future<List<SmartDevice>> build() async {
//     final AsyncValue<Database> db = ref.read(dbSembastAPIProvider);

//     return  db.when(data: (db)=>SmartDevice.fromJson( SembastApi.getAdditionalData(db: db, storeName: SembastApi.deviceStore) ) , 
//     error: (e, st) => AsyncError(e, st),
//         loading: () => const AsyncLoading());

    
//     return [];
//   }

//   Future<void> addDevice(SmartDevice device) async {
//     // The POST request will return a List<Todo> matching the new application state
//     final response = await ref.read(dbSembastAPIProvider.notifier).addDevice(device);

//     // Once the post request is done, we can mark the local cache as dirty.
//     // This will cause "build" on our notifier to asynchronously be called again,
//     // and will notify listeners when doing so.
//     ref.invalidateSelf();

//     // (Optional) We can then wait for the new state to be computed.
//     // This ensures "addTodo" does not complete until the new state is available.
//     await future;

//   }



//     

//     db.when(data: (db)async{
//     final newDevices = await SembastApi.getAdditionalData(db: db, storeName: SembastApi.deviceStore);



//     }, error: (e, st) => AsyncError(e, st),
//         loading: () => const AsyncLoading());
//     // We decode the API response and convert it to a List<Todo>
//     List<SmartDevice> newDevices = SembastApi.getAdditionalData(db: )
    
//     (jsonDecode(response.body) as List)
//         .cast<Map<String, Object?>>()
//         .map(Todo.fromJson)
//         .toList();

//     // We update the local cache to match the new state.
//     // This will notify all listeners.
//     state = AsyncData(newTodos);
//   }
// }

// @riverpod
// FutureOr<List<SmartDevice>> smartDeviceList(GetSmartDeviceListRef ref) {
//   FutureOr<List<SmartDevice>> getDevices() {
//     return state.when(
//         data: (db) => SembastApi.getAdditionalData(
//               db: db,
//               storeName: deviceStore,
//             ),
//         error: (e, st) => AsyncError(e, st),
//         loading: () => const AsyncLoading());
//   }
// }

// @riverpod
// class SembastKey extends _$SembastKey {
//   @override
//   int? build() {
//     return null;
//   }

//   void setKey(int newKey) {
//     state = newKey;
//   }

//   void resetKey() {
//     state = null;
//   }
// }

// @riverpod
// Future<SmartDevice> getSmartDevice(
//     GetSmartDeviceRef ref, int sembastKey) async {
//   final smartDevice = SembastApi.getSmartDevice(sembastKey);
//   return smartDevice;
// }
