import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_home_code_organizer/classes/building_class.dart';
import 'package:smart_home_code_organizer/classes/device_type_class.dart';
import 'package:smart_home_code_organizer/classes/floor_class.dart';
import 'package:smart_home_code_organizer/classes/room_class.dart';
import 'package:smart_home_code_organizer/classes/smart_device_class.dart';
import 'package:smart_home_code_organizer/providers/building_provider.dart';
import 'package:smart_home_code_organizer/providers/device_type_provider.dart';
import 'package:smart_home_code_organizer/providers/floor_provider.dart';
import 'package:smart_home_code_organizer/providers/room_provider.dart';
import 'package:smart_home_code_organizer/providers/smart_device_provider.dart';
import 'package:smart_home_code_organizer/screens/add_smart_device_screen.dart';
import 'package:smart_home_code_organizer/screens/filter_screen.dart';
import 'package:smart_home_code_organizer/screens/settings_screen.dart';
import 'package:smart_home_code_organizer/services/file_service.dart';
import 'package:smart_home_code_organizer/services/pdf_table_api.dart';
import 'package:smart_home_code_organizer/utils/constants.dart';
import 'package:smart_home_code_organizer/widgets/list/device_list_item.dart';
import 'package:smart_home_code_organizer/widgets/start/link_button.dart';

class HomeListScreen extends ConsumerWidget {
  const HomeListScreen({super.key});

  static const route = '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<DeviceType>> deviceTypeListAsync =
        ref.watch(deviceTypeListProvider);
    final AsyncValue<List<Building>> buildingListAsync =
        ref.watch(buildingListProvider);
    final AsyncValue<List<Floor>> floorListAsync = ref.watch(floorListProvider);
    final AsyncValue<List<Room>> roomListAsync = ref.watch(roomListProvider);
    final AsyncValue<List<SmartDevice>> smartDeviceListAsync =
        ref.watch(smartDeviceListProvider);
    final AsyncValue<List<SmartDevice>> smartDeviceFilterAsync =
        ref.watch(smartDeviceFilterListProvider);

    /// just watch the filter provider so that they are not rebuild when filterscreen is entered
    // ignore: unused_local_variable
    final typeFilter = ref.watch(deviceTypeFilterProvider);
    // ignore: unused_local_variable
    final buildingFilter = ref.watch(buildingFilterProvider);
    // ignore: unused_local_variable
    final floorFilter = ref.watch(floorFilterProvider);
    // ignore: unused_local_variable
    final roomFilter = ref.watch(roomFilterProvider);

    // Future<String?> deviceDialog(
    //     BuildContext context, SmartDevice smartDevice, WidgetRef ref) {
    //   return showDialog<String>(
    //     context: context,
    //     builder: (BuildContext context) => AlertDialog(
    //       title: Text(smartDevice.name),
    //       content: const Text('Gerät bearbeiten oder löschen?'),
    //       actions: <Widget>[
    //         TextButton(
    //           onPressed: () async {
    //             await showDialog<String>(
    //               context: context,
    //               builder: (BuildContext context) => AlertDialog(
    //                 title: Text(smartDevice.name),
    //                 content: Column(
    //                   mainAxisSize: MainAxisSize.min,
    //                   children: [
    //                     const Text('Gerät wirklich löschen?',
    //                         style: TextStyle(fontWeight: FontWeight.bold)),
    //                     const SizedBox(
    //                       height: 20,
    //                     ),
    //                     Text(smartDevice.name),
    //                     Text(smartDevice.sgtin),
    //                     Text(smartDevice.floor),
    //                     Text(smartDevice.room),
    //                   ],
    //                 ),
    //                 actions: <Widget>[
    //                   TextButton(
    //                     onPressed: () {
    //                       ref
    //                           .read(smartDeviceListProvider.notifier)
    //                           .deleteSmartDevice(smartDevice);
    //                       Navigator.pop(context);
    //                     },
    //                     child: const Text(
    //                       'löschen',
    //                       style: TextStyle(
    //                           color: Colors.red, fontWeight: FontWeight.bold),
    //                     ),
    //                   ),
    //                   TextButton(
    //                     onPressed: () => Navigator.pop(context, 'Cancel'),
    //                     child: const Text('abbrechen'),
    //                   ),
    //                 ],
    //               ),
    //             );
    //             Navigator.pop(context);
    //           },
    //           child: const Text(
    //             'löschen',
    //             style:
    //                 TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
    //           ),
    //         ),
    //         TextButton(
    //           onPressed: () => Navigator.pop(context, 'Cancel'),
    //           child: const Text('abbrechen'),
    //         ),
    //         TextButton(
    //           onPressed: () {
    //             Navigator.popAndPushNamed(
    //               context,
    //               AddSmartDeviceScreen.route,
    //             );
    //           },
    //           child: const Text('bearbeiten'),
    //         ),
    //       ],
    //     ),
    //   );
    // }

    return deviceTypeListAsync.when(
        error: (e, st) => Text(e.toString()),
        loading: () => const CircularProgressIndicator(),
        data: (data) {
          if (data.isNotEmpty) {
            return smartDeviceFilterAsync.when(
              error: (e, st) => Text(e.toString()),
              loading: () => const CircularProgressIndicator(),
              data: (smartDeviceFilterList) => Scaffold(
                appBar: deviceTypeListAsync.when(
                  error: (e, st) => null,
                  loading: () => null,
                  data: (data) {
                    if (data.isNotEmpty) {
                      return AppBar(
                        title: const Text('Organizer'),
                        actions: [
                          IconButton(
                              onPressed: () => Navigator.pushNamed(
                                  context, SettingsScreen.route),
                              icon: const Icon(Icons.settings))
                        ],
                      );
                    } else {
                      return AppBar(
                        title: const Text('Organizer'),
                      );
                    }
                  },
                ),
                bottomNavigationBar: BottomAppBar(
                  color: Theme.of(context).colorScheme.primary,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          color: Theme.of(context).colorScheme.onPrimary,
                          onPressed: () =>
                              Navigator.pushNamed(context, FilterScreen.route),
                          icon: const Icon(Icons.filter_alt)),
                      IconButton(
                        color: Theme.of(context).colorScheme.onPrimary,
                        onPressed: () async {
                          final File pdfFile =
                              await TablePdfApi.generateTablePdf(
                                  deviceList: smartDeviceFilterList);
                          SaveAndOpenDocument.openPdf(pdfFile);
                        },
                        icon: const Icon(Icons.print),
                      ),
                    ],
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    ref
                        .read(smartDeviceFocusProvider.notifier)
                        .resetAllValues();
                    Navigator.pushNamed(context, AddSmartDeviceScreen.route);
                  },
                  child: const Icon(Icons.add_circle),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
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
                          child: Column(
                            children: [
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text:
                                      'Hallo, wenn du fortfährst, stimmst du unseren',
                                  style: Theme.of(context).textTheme.bodySmall,
                                  children: const <InlineSpan>[
                                    WidgetSpan(
                                      alignment: PlaceholderAlignment.baseline,
                                      baseline: TextBaseline.alphabetic,
                                      child: LinkButton(
                                          urlLabel: "Nutzungsbedingungen",
                                          url: termsOfUseUrl),
                                    ),
                                    TextSpan(
                                      text:
                                          ' zu und bestätigst, dass du unsere ',
                                    ),
                                    WidgetSpan(
                                      alignment: PlaceholderAlignment.baseline,
                                      baseline: TextBaseline.alphabetic,
                                      child: LinkButton(
                                          urlLabel: "Datenschutzrichtlinie ",
                                          url: privacyUrl),
                                    ),
                                    TextSpan(
                                      text: ' gelesen und akzeptiert hast.',
                                    ),
                                  ],
                                ),
                              ),
                              FilledButton(
                                onPressed: () async {
                                  await ref
                                      .read(deviceTypeListProvider.notifier)
                                      .addBasicTypes();
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
                                child: const Text('zustimmen und Weiter'),
                              ),
                            ],
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
                            loading: () => CircularProgressIndicator(
                                color: Colors.blue[800]),
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
                                    child:
                                        const Text('hinterlege standard Räume'),
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
                                              .read(
                                                  buildingListProvider.notifier)
                                              .addBasicBuilding();
                                        },
                                        child: const Text('hinterlege Haus'),
                                      ),
                                    );
                                  }

                                  /// finally all basic data is loaded and the normal app can be shown.
                                  return smartDeviceFilterAsync.when(
                                    error: (e, st) => Text(e.toString()),
                                    loading: () =>
                                        const CircularProgressIndicator(),
                                    data: (smartDeviceFilterList) {
                                      return smartDeviceListAsync.when(
                                        error: (e, st) => Text(e.toString()),
                                        loading: () =>
                                            const CircularProgressIndicator(),
                                        data: (smartDeviceList) {
                                          bool isFiltered =
                                              smartDeviceFilterList.length !=
                                                  smartDeviceList.length;

                                          return Column(
                                            children: [
                                              isFiltered
                                                  ? Column(children: [
                                                      const Text(
                                                        'Filter',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16),
                                                      ),
                                                      Text(
                                                        'Treffer: ${smartDeviceFilterList.length} von ${smartDeviceList.length}',
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16),
                                                      )
                                                    ])
                                                  : const Text(
                                                      'Alle Einträge',
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    ),
                                              Expanded(
                                                child: ListView.separated(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  itemCount:
                                                      smartDeviceFilterList
                                                          .length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    SmartDevice smartDevice =
                                                        smartDeviceFilterList[
                                                            index];
                                                    return DeviceListItem(
                                                        smartDevice:
                                                            smartDevice);
                                                  },
                                                  separatorBuilder:
                                                      (BuildContext context,
                                                              int index) =>
                                                          const Divider(),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
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
              ),
            );
          }

          return Scaffold(
              appBar: AppBar(
                title: const Text('Organize'),
              ),
              body: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Hallo, wenn du fortfährst, stimmst du unseren',
                      style: Theme.of(context).textTheme.bodySmall,
                      children: const <InlineSpan>[
                        WidgetSpan(
                          alignment: PlaceholderAlignment.baseline,
                          baseline: TextBaseline.alphabetic,
                          child: LinkButton(
                              urlLabel: "Nutzungsbedingungen",
                              url: termsOfUseUrl),
                        ),
                        TextSpan(
                          text: ' zu und bestätigst, dass du unsere ',
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.baseline,
                          baseline: TextBaseline.alphabetic,
                          child: LinkButton(
                              urlLabel: "Datenschutzrichtlinie ",
                              url: privacyUrl),
                        ),
                        TextSpan(
                          text: ' gelesen und akzeptiert hast.',
                        ),
                      ],
                    ),
                  ),

                  /// first time when App is started the database has no data
                  FilledButton(
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
                    child: const Text('zustimmen und weiter'),
                  ),
                ],
              ));
        });
  }
}
