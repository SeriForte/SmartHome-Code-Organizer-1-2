import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:smart_home_code_organizer/classes/smart_device_class.dart';

class SembastApi {
  static const String typeStore = 'type';
  static const String typeUniqueFilter = 'name';

  static const String floorStore = 'floor';
  static const String floorUniqueFilter = 'name';

  static const String roomStore = 'room';
  static const String roomUniqueFilter = 'name';

  static const String buildingStore = 'building';
  static const String buildingUniqueFilter = 'name';

  static const String deviceStore = 'smartDevice';
  static const String deviceUniqueFilter = 'sgtin';

  static Future<Database> connect() async {
    // get the application documents directory

    /// Opening a database means loading its content in memory.
    /// This is an expensive operation.
    /// In an application (flutter, web),
    /// the recommended way is to open the database on start and to keep it open during the lifetime of the application.
    ///
    ///
    debugPrint('connect to Database (connect())');
    final dir = await getApplicationDocumentsDirectory();
// make sure it exists
    await dir.create(recursive: true);
// build the database path
    final dbPath = join(dir.path, 'smart_device_organizer.db');
// open the database
    final db = await databaseFactoryIo.openDatabase(dbPath);

    return db;
  }

  static Future<String> getDBPath() async {
    debugPrint('connect to Database (getDBPath())');
    final dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true);
// build the database path
    final dbPath = join(dir.path, 'smart_device_organizer.db');

    return dbPath;
  }

  /// universal create or update Method
  static Future<void> addOrUpdateData(
      {required Database db,
      required String storeName,
      required String uniqueFilter,
      required Map<String, Object?> map}) async {
    // Check if the record exists before adding or updating it.
    var store = intMapStoreFactory.store(storeName);

    // create floor, room, type, device

    debugPrint('SembastApi addOrUpdateData()');
    debugPrint('map= ${map.toString()}');

    await db.transaction((txn) async {
      // Look of existing record
      var existing = await store
          .query(
              finder: Finder(
                  filter: Filter.equals(uniqueFilter, map[uniqueFilter])))
          .getSnapshot(txn);
      if (existing == null) {
        // code not found, add
        await store.add(txn, map);
      } else {
        // Update existing
        await existing.ref.update(txn, map);
      }
    });
  }

  /// reset FavoriteBuilding
  static Future<void> toogleBuildingFavorites(
      {required Database db, required Map<String, Object?> newFavorite}) async {
    // Check if the record exists before adding or updating it.
    var store = intMapStoreFactory.store(buildingStore);

    // debugPrint('SembastApi toogleFavorites()');

    // Filter for updating records (all that are saved as favorite)
    var finderOldFavorite = Finder(filter: Filter.equals('isFavorite', true));
    var finderNewFavorite =
        Finder(filter: Filter.equals('name', newFavorite['name']));

    /// debug only, get List of all Records
    var finderAll = Finder(filter: Filter.notNull('name'));
    var records1 = await store.find(db, finder: finderAll);

    debugPrint(records1.toString());

    // Update within transaction
    await db.transaction((txn) async {
      // Look of existing Favorite record
      var oldFavorite =
          await store.query(finder: finderOldFavorite).getSnapshot(txn);
      var newFavorite =
          await store.query(finder: finderNewFavorite).getSnapshot(txn);
      if (oldFavorite == null) {
        // no entry found not found, add
        // debugPrint('no Entry (oldFavorite) found');
      } else {
        // debugPrint('found oldFavorite entry: $oldFavorite');
        // debugPrint('found oldFavorite entry: ${oldFavorite.value}');
        Map<String, Object?> updateOldFavorite = {
          'name': oldFavorite.value['name'],
          'isFavorite': false
        };
        Map<String, Object?> updateNewFavorite = {
          'name': newFavorite!['name'],
          'isFavorite': true
        };

        // Update oldFavorite
        await oldFavorite.ref.update(txn, updateOldFavorite);
        // debugPrint('updated entry (old): $updateOldFavorite');

        // Update newFavorite
        await newFavorite.ref.update(txn, updateNewFavorite);
        // debugPrint('updated entry (new): $updateNewFavorite');
      }
    });

    // var records2 = await store.find(db, finder: finderAll);
    // debugPrint(records2.toString());
  }

  /// universal get Method for floor, room, type
  static Future<List<RecordSnapshot<int, Map<String, Object?>>>> getData({
    required Database db,
    required String storeName,
  }) async {
    var store = intMapStoreFactory.store(storeName);

    var finder = Finder(sortOrders: [
      SortOrder('name'),
    ]);
    var records = await store.find(db, finder: finder);

    return records;
  }

  /// filter Method for floor, room and type
  static Future<List<SmartDevice>> filterSmartDevice({
    required Database db,
    String storeName = deviceStore,
    List<String> typeList = const [],
    List<String> floorList = const [],
    List<String> roomList = const [],
  }) async {
    var store = intMapStoreFactory.store(storeName);
    List<SmartDevice> smartDevices = [];

    List<Filter> completeFilter = [];
    if (typeList.isNotEmpty) {
      completeFilter.add(
        Filter.inList('deviceType', typeList),
      );
    }
    if (floorList.isNotEmpty) {
      completeFilter.add(
        Filter.inList('floor', floorList),
      );
    }
    if (roomList.isNotEmpty) {
      completeFilter.add(
        Filter.inList('room', roomList),
      );
    }

    var filter = Filter.and(completeFilter);
    var finder = Finder(filter: filter, sortOrders: [
      SortOrder('name'),
    ]);
    var records = await store.find(db, finder: finder);
    for (var element in records) {
      smartDevices.add(SmartDevice(
        qrCode: element['qrCode'].toString(),
        deviceType: element['deviceType'].toString(),
        smartKey: element['smartKey'].toString(),
        sgtin: element['sgtin'].toString(),
        name: element['name'].toString(),
        description: element['description'].toString(),
        room: element['room'].toString(),
        floor: element['floor'].toString(),
        building: element['building'].toString(),
        sembastKey: int.tryParse(element['sembastKey'].toString()),
      ));
    }

    return smartDevices;
  }

  /// get SGTIN Numbers
  static Future<List<String>> getAllSGTIN({
    required Database db,
  }) async {
    List<String> sgtinList = [];
    var store = intMapStoreFactory.store(deviceStore);

    var records = await store.find(db);
    for (var r in records) {
      sgtinList.add(r.value['sgtin'].toString());
    }

    return sgtinList;
  }

  /// universal delete Method
  static Future<void> deleteData(
      {required Database db,
      required String storeName,
      required String uniqueFilter,
      required String uniqueIdentifier}) async {
    // Check if the record exists before adding or updating it.
    var store = intMapStoreFactory.store(storeName);

    // create floor, room, type, device

    await db.transaction((txn) async {
      await store.delete(txn,
          finder:
              Finder(filter: Filter.equals(uniqueFilter, uniqueIdentifier)));
    });
  }

  //
  //
  //
  //
  //
  //    OLD CODE BELOW
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //

  /// Either add or modify records with a given 'name'
  static Future<void> addOrUpdateAdditionalData(
      {required Database db,
      required String storeName,
      required String uniqueFilter,
      required Map<String, Object?> map}) async {
    // Check if the record exists before adding or updating it.
    var store = intMapStoreFactory.store(storeName);

    // create floor, room, type, device

    await db.transaction((txn) async {
      // Look of existing record
      var existing = await store
          .query(
              finder: Finder(
                  filter: Filter.equals(uniqueFilter, map[uniqueFilter])))
          .getSnapshot(txn);
      if (existing == null) {
        // code not found, add
        await store.add(txn, map);
      } else {
        // Update existing
        await existing.ref.update(txn, map);
      }
    });
  }

  // static Future<void> storeSmartDevice(
  //     Database db, SmartDevice newSmartDevice) async {
  //   final Database db = await connect();

  //   var store = intMapStoreFactory.store('smartDevice');

  //   // var store = StoreRef<int, Map>.main();
  //   // Auto incrementation is built-in
  //   var sembastKey = await store.add(db, {
  //     'qrCode': newSmartDevice.qrCode,
  //     'deviceType': newSmartDevice.deviceType,
  //     'smartKey': newSmartDevice.smartKey,
  //     'sgtin': newSmartDevice.sgtin,
  //     'name': newSmartDevice.name,
  //     'description': newSmartDevice.description,
  //     'room': newSmartDevice.room,
  //     'floor': newSmartDevice.floor,
  //     'building': newSmartDevice.building,
  //   });

  //   SmartDevice newSmartDeviceWithKey = SmartDevice(
  //     qrCode: newSmartDevice.qrCode,
  //     deviceType: newSmartDevice.deviceType,
  //     smartKey: newSmartDevice.smartKey,
  //     sgtin: newSmartDevice.sgtin,
  //     name: newSmartDevice.name,
  //     description: newSmartDevice.description,
  //     room: newSmartDevice.room,
  //     floor: newSmartDevice.floor,
  //     building: newSmartDevice.building,
  //     sembastKey: sembastKey,
  //   );

  //   await updateSmartDevice(
  //       sembastKey: sembastKey, newSmartDevice: newSmartDeviceWithKey);
  // }

  /// get the relevant data
  static Future<Map<String, Object?>> getAdditionalData(
      {required Database db, required String storeName}) async {
    var store = intMapStoreFactory.store(storeName);

    var finder = Finder(sortOrders: [
      SortOrder('name'),
    ]);
    var records = await store.find(db, finder: finder);
    return records.first.value;
  }

  static Future<void> updateSmartDevice(
      {required int sembastKey, required SmartDevice newSmartDevice}) async {
    final Database db = await connect();

    var store = intMapStoreFactory.store('smartDevice');

    // Read by key
    var oldRecord = await store.record(sembastKey).get(db);

    if (oldRecord != null) {
      // Retrieve the record
      var record = store.record(sembastKey);
// Update the record
      await record.put(
          db,
          {
            'qrCode': newSmartDevice.qrCode,
            'deviceType': newSmartDevice.deviceType,
            'smartKey': newSmartDevice.smartKey,
            'sgtin': newSmartDevice.sgtin,
            'name': newSmartDevice.name,
            'description': newSmartDevice.description,
            'room': newSmartDevice.room,
            'floor': newSmartDevice.floor,
            'building': newSmartDevice.building,
            'sembastKey': sembastKey,
          },
          merge: true);
    } else {
      debugPrint('Error, Sembast Key does not exist');
    }
  }

  static Future<SmartDevice> getSmartDevice(int sembastKey) async {
    final Database db = await connect();

    var store = intMapStoreFactory.store('smartDevice');

    // Read by key
    var record = await store.record(sembastKey).get(db);

    if (record != null) {
      SmartDevice smartDevice = SmartDevice(
        qrCode: record['qrCode'].toString(),
        deviceType: record['deviceType'].toString(),
        smartKey: record['smartKey'].toString(),
        sgtin: record['sgtin'].toString(),
        name: record['name'].toString(),
        description: record['description'].toString(),
        room: record['room'].toString(),
        floor: record['floor'].toString(),
        building: record['building'].toString(),
        sembastKey: int.tryParse(record['sembastKey'].toString()),
      );
      return smartDevice;
    } else {
      throw Error();
    }
  }

  static Future<void> deleteSmartDevice(int sembastKey) async {
    final Database db = await connect();

    var store = intMapStoreFactory.store('smartDevice');

    // Record by key.
    var record = await store.record(sembastKey).get(db);

    if (record != null) {
      var record = store.record(sembastKey);
// Delete the record.
      await record.delete(db);
    } else {
      throw Error();
    }
  }

  static Future<List<Map<String, Object?>>> getAllSmartDevices(
      Database db) async {
    // List<Map<String, Object?>> smartDevices = [];
    // final Database db = await connect();

    var store = intMapStoreFactory.store('smartDevice');

    var finder = Finder(sortOrders: [
      SortOrder('building'),
      SortOrder('floor'),
      SortOrder('room')
    ]);
    var records = await store.find(db, finder: finder);

    // for (var element in records) {
    //   smartDevices.add(SmartDevice(
    //     qrCode: element['qrCode'].toString(),
    //     deviceType: element['deviceType'].toString(),
    //     smartKey: element['smartKey'].toString(),
    //     sgtin: element['sgtin'].toString(),
    //     name: element['name'].toString(),
    //     description: element['description'].toString(),
    //     room: element['room'].toString(),
    //     floor: element['floor'].toString(),
    //     building: element['building'].toString(),
    //     sembastKey: int.tryParse(element['sembastKey'].toString()),
    //   ));
    // }

    return records.values.toList();
  }

  static Future<void> updateNullKeys() async {
    // only for debug use
    // ignore: unused_local_variable
    final Database db = await connect();

    // ignore: unused_local_variable
    var store = intMapStoreFactory.store('smartDevice');

    // // Update the record
    // var record0 = store.record(0);
    // await record0.delete(db);

    // // Update the record
    // var record1 = store.record(1);
    // await record1.put(db, {'sembastKey': 1}, merge: true);

    // // Update the record
    // var record2 = store.record(2);
    // await record2.put(db, {'sembastKey': 2}, merge: true);

    // // Update the record
    // var record3 = store.record(3);
    // await record3.put(db, {'sembastKey': 3}, merge: true);
  }

  static void resetFavorites({required Database db}) {}
}
