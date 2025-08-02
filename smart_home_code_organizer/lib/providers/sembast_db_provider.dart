import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sembast/sembast.dart';
import 'package:smart_home_code_organizer/classes/smart_device_class.dart';
import 'package:smart_home_code_organizer/services/sembast_service.dart';

part 'sembast_db_provider.g.dart';

@Riverpod(keepAlive: true)
class DbSembastAPI extends _$DbSembastAPI {
  final String typeStore = 'type';
  final String typeUniqueFilter = 'name';

  final String floorStore = 'floor';
  final String floorUniqueFilter = 'name';

  final String roomStore = 'room';
  final String roomUniqueFilter = 'name';

  final String deviceStore = 'smartDevice';
  final String deviceUniqueFilter = 'sgtin';

  @override
  FutureOr<Database> build() {
    state = const AsyncLoading();
    return SembastApi.connect();
  }

  FutureOr<void> addType(Map<String, Object?> type) {
    state.when(
        data: (db) => SembastApi.addOrUpdateAdditionalData(
              db: db,
              storeName: typeStore,
              uniqueFilter: typeUniqueFilter,
              map: type,
            ),
        error: (e, st) => AsyncError(e, st),
        loading: () => const AsyncLoading());
  }

  FutureOr<void> addFloor(Map<String, Object?> floor) {
    state.when(
        data: (db) => SembastApi.addOrUpdateAdditionalData(
              db: db,
              storeName: typeStore,
              uniqueFilter: floorUniqueFilter,
              map: floor,
            ),
        error: (e, st) => AsyncError(e, st),
        loading: () => const AsyncLoading());
  }

  FutureOr<void> addRoom(Map<String, Object?> room) {
    state.when(
        data: (db) => SembastApi.addOrUpdateAdditionalData(
              db: db,
              storeName: typeStore,
              uniqueFilter: roomUniqueFilter,
              map: room,
            ),
        error: (e, st) => AsyncError(e, st),
        loading: () => const AsyncLoading());
  }

  FutureOr<void> addDevice(SmartDevice device) {
    state.when(
        data: (db) => SembastApi.addOrUpdateAdditionalData(
            db: db,
            storeName: typeStore,
            uniqueFilter: deviceUniqueFilter,
            map: device.toJson()),
        error: (e, st) => AsyncError(e, st),
        loading: () => const AsyncLoading());
  }

  FutureOr<dynamic> getTypes() {
    state.when(
        data: (db) => SembastApi.getAdditionalData(
              db: db,
              storeName: typeStore,
            ),
        error: (e, st) => AsyncError(e, st),
        loading: () => const AsyncLoading());
  }

  FutureOr<dynamic> getFloors() {
    state.when(
        data: (db) => SembastApi.getAdditionalData(
              db: db,
              storeName: floorStore,
            ),
        error: (e, st) => AsyncError(e, st),
        loading: () => const AsyncLoading());
  }

  FutureOr<dynamic> getRooms() {
    state.when(
        data: (db) => SembastApi.getAdditionalData(
              db: db,
              storeName: roomStore,
            ),
        error: (e, st) => AsyncError(e, st),
        loading: () => const AsyncLoading());
  }

  FutureOr<dynamic> getDevices() {
    return state.when(
        data: (db) => SembastApi.getAdditionalData(
              db: db,
              storeName: deviceStore,
            ),
        error: (e, st) => AsyncError(e, st),
        loading: () => const AsyncLoading());
  }
}
