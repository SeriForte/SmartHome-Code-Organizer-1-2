import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_home_code_organizer/classes/building_class.dart';
import 'package:smart_home_code_organizer/classes/device_type_class.dart';
import 'package:smart_home_code_organizer/classes/floor_class.dart';
import 'package:smart_home_code_organizer/classes/room_class.dart';
import 'package:smart_home_code_organizer/providers/building_provider.dart';
import 'package:smart_home_code_organizer/providers/device_type_provider.dart';
import 'package:smart_home_code_organizer/providers/floor_provider.dart';
import 'package:smart_home_code_organizer/providers/room_provider.dart';
import 'package:smart_home_code_organizer/providers/smart_device_provider.dart';
import 'package:smart_home_code_organizer/screens/add_smart_device_screen.dart';
import 'package:smart_home_code_organizer/screens/settings_screen.dart';
import 'package:smart_home_code_organizer/utils/constants.dart';
import 'package:smart_home_code_organizer/screens/list_smart_device_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const route = '/home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<DeviceType>> deviceTypeListAsync =
        ref.watch(deviceTypeListProvider);
    final AsyncValue<List<Building>> buildingListAsync =
        ref.watch(buildingListProvider);
    final AsyncValue<List<Floor>> floorListAsync = ref.watch(floorListProvider);
    final AsyncValue<List<Room>> roomListAsync = ref.watch(roomListProvider);

    /// just watch the filter provider so that they are not rebuild when filterscreen is entered
    // ignore: unused_local_variable
    final typeFilter = ref.watch(deviceTypeFilterProvider);
    // ignore: unused_local_variable
    final buildingFilter = ref.watch(buildingFilterProvider);
    // ignore: unused_local_variable
    final floorFilter = ref.watch(floorFilterProvider);
    // ignore: unused_local_variable
    final roomFilter = ref.watch(roomFilterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Home Code Organizer'),
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, SettingsScreen.route),
              icon: const Icon(Icons.settings))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: deviceTypeListAsync.when(
            error: (e, st) => Text(e.toString()),
            loading: () => CircularProgressIndicator(
                  color: Colors.blue[200],
                ),
            data: (deviceTypeList) {
              if (deviceTypeList.isEmpty) {
                /// first time when App is started the database has no data
                return Center(
                  child: FilledButton(
                    onPressed: () async {
                      await ref
                          .read(deviceTypeListProvider.notifier)
                          .addBasicTypes();
                      await ref
                          .read(floorListProvider.notifier)
                          .addBasicFloors();
                      await ref.read(roomListProvider.notifier).addBasicRoom();
                    await ref
                        .read(buildingListProvider.notifier)
                        .addBasicBuilding();
                    },
                    child: const Text('lade standard Gerätetypen'),
                  ),
                );
              }
              return floorListAsync.when(
                error: (e, st) => Text(e.toString()),
                loading: () => const CircularProgressIndicator(
                  color: Colors.blue,
                ),
                data: (floorList) {
                  if (floorList.isEmpty) {
                    return Center(
                      child: FilledButton(
                      onPressed: () async {
                        await ref
                            .read(floorListProvider.notifier)
                            .addBasicFloors();
                        await ref
                            .read(roomListProvider.notifier)
                            .addBasicRoom();
                        await ref
                            .read(buildingListProvider.notifier)
                            .addBasicBuilding();
                        },
                        child: const Text('hinterlege standard Etagen'),
                      ),
                    );
                  }
                  return roomListAsync.when(
                    error: (e, st) => Text(e.toString()),
                    loading: () =>
                        CircularProgressIndicator(color: Colors.blue[800]),
                    data: (roomList) {
                      if (roomList.isEmpty) {
                        return Center(
                          child: FilledButton(
                          onPressed: () async {
                            await ref
                                  .read(roomListProvider.notifier)
                                  .addBasicRoom();
                            await ref
                                .read(buildingListProvider.notifier)
                                .addBasicBuilding();
                          },
                          child: const Text('hinterlege standard Räume'),
                        ),
                      );
                    }

                    return buildingListAsync.when(
                      error: (e, st) => Text(e.toString()),
                      loading: () => const CircularProgressIndicator(
                          color: Color.fromARGB(255, 8, 49, 97)),
                      data: (buidlingList) {
                        if (buidlingList.isEmpty) {
                          return Center(
                            child: FilledButton(
                              onPressed: () async {
                                await ref
                                    .read(buildingListProvider.notifier)
                                    .addBasicBuilding();
                              },
                              child: const Text('hinterlege Haus'),
                            ),
                          );
                        }


                        /// finally all basic data is loaded and the normal app can be shown.
                        return SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: double.infinity,
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xfff5f5f5),
                                      Color(0xfffef7ff)
                                    ],
                                    stops: [0, 1],
                                    begin: Alignment.bottomRight,
                                    end: Alignment.topLeft,
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(designBorderRadius),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withValues(alpha:  0.2),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                    ),
                                  ],
                                ),
                                height: 300,
                                width: 380,
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Organisiere Codes von Smart Home Geräten',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      ListTile(
                                        leading: Icon(
                                            Icons.download_for_offline_sharp),
                                        title: Text(
                                          'Exportiere die Listen als PDFs',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.search),
                                        title: Text(
                                          'Verliere keinen Code',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.newspaper_outlined),
                                        title: Text(
                                          'Behalte die Übersicht',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              InkWell(
                                onTap: () => Navigator.pushNamed(
                                    context, ListSmartDeviceScreen.route),
                                child: Container(
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xffede574),
                                          Color(0xffe1f5c4)
                                        ],
                                        stops: [0, 1],
                                        begin: Alignment.bottomRight,
                                        end: Alignment.topLeft,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          designBorderRadius),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withValues(alpha:  0.3),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                        ),
                                      ],
                                    ),
                                    height: 80,
                                    width: 300,
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(
                                          Icons.list,
                                          size: 50,
                                        ),
                                        Text(
                                          'Code anzeigen',
                                          style: TextStyle(fontSize: 22),
                                        ),
                                      ],
                                    )),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              InkWell(
                                onTap: () {
                                  ref
                                      .read(smartDeviceFocusProvider.notifier)
                                      .resetAllValues();
                                  Navigator.pushNamed(
                                      context, AddSmartDeviceScreen.route);
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color.fromARGB(255, 35, 194, 139),
                                          Color(0xff93f9b9)
                                        ],
                                        stops: [0, 1],
                                        begin: Alignment.bottomRight,
                                        end: Alignment.topLeft,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          designBorderRadius),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withValues(alpha:  0.3),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                        ),
                                      ],
                                    ),
                                    height: 80,
                                    width: 300,
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(
                                          Icons.add_circle,
                                          size: 50,
                                        ),
                                        Text(
                                          'Code hinzufügen',
                                          style: TextStyle(fontSize: 22),
                                        ),
                                      ],
                                    )),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        );
                      },
                      );
                    },
                  );
                },
              );
          },
        ),
      ),
    );
  }
}
