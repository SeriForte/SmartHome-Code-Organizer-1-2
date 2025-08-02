import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_home_code_organizer/providers/device_type_provider.dart';
import 'package:smart_home_code_organizer/providers/floor_provider.dart';
import 'package:smart_home_code_organizer/providers/room_provider.dart';

part 'basic_values_provider.g.dart';

@riverpod
FutureOr<String> basicValues(Ref ref) {
  final deviceTypeList = ref.read(deviceTypeListProvider);
  final floorList = ref.read(floorListProvider);
  final roomList = ref.read(roomListProvider);

  if (deviceTypeList is AsyncError ||
      floorList is AsyncError ||
      roomList is AsyncError) {
    return 'Error';
  }
  if (deviceTypeList is AsyncLoading ||
      floorList is AsyncLoading ||
      roomList is AsyncLoading) {
    return 'loading';
  }

  return 'ready';
}
