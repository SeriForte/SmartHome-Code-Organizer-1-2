import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:smart_home_code_organizer/classes/smart_device_class.dart';
import 'package:smart_home_code_organizer/providers/smart_device_provider.dart';
import 'package:smart_home_code_organizer/screens/add_smart_device_screen.dart';
import 'package:smart_home_code_organizer/screens/filter_screen.dart';
import 'package:smart_home_code_organizer/services/file_service.dart';
import 'package:smart_home_code_organizer/services/pdf_table_api.dart';
import 'package:smart_home_code_organizer/widgets/list/device_list_item.dart';

class ListSmartDeviceScreen extends ConsumerStatefulWidget {
  const ListSmartDeviceScreen({super.key});

  static const route = '/list';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ListSmartDeviceScreenState();
}

class _ListSmartDeviceScreenState extends ConsumerState<ListSmartDeviceScreen> {
  Future<String?> deviceDialog(
      BuildContext context, SmartDevice smartDevice, WidgetRef ref) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(smartDevice.name),
        content: const Text('Gerät bearbeiten oder löschen?'),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              await showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text(smartDevice.name),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Gerät wirklich löschen?',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(smartDevice.name),
                      Text(smartDevice.sgtin),
                      Text(smartDevice.floor),
                      Text(smartDevice.room),
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        ref
                            .read(smartDeviceListProvider.notifier)
                            .deleteSmartDevice(smartDevice);

                        Navigator.pop(context);
                      },
                      child: const Text(
                        'löschen',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('abbrechen'),
                    ),
                  ],
                ),
              );

              Navigator.pop(context);
            },
            child: const Text(
              'löschen',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('abbrechen'),
          ),
          TextButton(
            onPressed: () {
              Navigator.popAndPushNamed(
                context,
                AddSmartDeviceScreen.route,
              );
            },
            child: const Text('bearbeiten'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<SmartDevice>> smartDeviceListAsync =
        ref.watch(smartDeviceListProvider);
    final AsyncValue<List<SmartDevice>> smartDeviceFilterAsync =
        ref.watch(smartDeviceFilterListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Device Overview'),
        actions: [
          IconButton(
              onPressed: () => Navigator.pushNamed(context, FilterScreen.route),
              icon: const Icon(Icons.filter_alt)),
          smartDeviceFilterAsync.when(
            error: (e, st) => Text(e.toString()),
            loading: () => const CircularProgressIndicator(),
            data: (smartDeviceFilterList) => IconButton(
                onPressed: () async {
                  final File pdfFile = await TablePdfApi.generateTablePdf(
                      deviceList: smartDeviceFilterList);
                  SaveAndOpenDocument.openPdf(pdfFile);
                },
                icon: const Icon(Icons.print)),
          ),
        ],
      ),
      body: smartDeviceFilterAsync.when(
          error: (e, st) => Text(e.toString()),
          loading: () => const CircularProgressIndicator(),
          data: (smartDeviceFilterList) => Column(
                children: [
                  Column(
                    children: [
                      const Text(
                        'Filter',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      smartDeviceListAsync.when(
                        error: (e, st) => Text(e.toString()),
                        loading: () => const CircularProgressIndicator(),
                        data: (smartDeviceList) => Text(
                          'Treffer: ${smartDeviceFilterList.length} von ${smartDeviceList.length}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(8),
                      itemCount: smartDeviceFilterList.length,
                      itemBuilder: (BuildContext context, int index) {
                        SmartDevice smartDevice = smartDeviceFilterList[index];
                        return DeviceListItem(smartDevice: smartDevice);

                        // ListTile(
                        //   onLongPress: () {
                        //     ref
                        //         .read(smartDeviceFocusProvider.notifier)
                        //         .setAllValues(smartDevice);
                        //     deviceDialog(context, smartDevice, ref);
                        //   },
                        //   title: Text(smartDevice.name),
                        //   subtitle: Column(
                        //     children: [
                        //       Text(smartDevice.description),
                        //       Text(smartDevice.deviceType),
                        //       Text(smartDevice.building),
                        //     ],
                        //   ),
                        //   leading: SizedBox(
                        //     width: 50,
                        //     child: Column(
                        //       children: [
                        //         Text(
                        //           smartDevice.smartKey.toString(),
                        //           overflow: TextOverflow.ellipsis,
                        //         ),
                        //         Text(
                        //           smartDevice.room,
                        //           overflow: TextOverflow.ellipsis,
                        //         ),
                        //         Text(
                        //           smartDevice.floor,
                        //           overflow: TextOverflow.ellipsis,
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                    ),
                  ),
                ],
              )),
    );
  }
}
