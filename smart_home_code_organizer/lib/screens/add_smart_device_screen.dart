import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
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
import 'package:smart_home_code_organizer/utils/constants.dart';

class AddSmartDeviceScreen extends ConsumerStatefulWidget {
  const AddSmartDeviceScreen({super.key});

  static const route = '/add';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddSmartDeviceScreenState();
}

class _AddSmartDeviceScreenState extends ConsumerState<AddSmartDeviceScreen> {
  final qrCodeController = TextEditingController();
  final deviceTypeController = TextEditingController();
  final smartKeyController = TextEditingController();
  final sgtinController = TextEditingController();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final roomController = TextEditingController();
  final floorController = TextEditingController();
  final buildingController = TextEditingController();
  int? sembastKey;
  String? _valueDeviceType;
  String? _valueRoom;
  String? _valueFloor;
  String? _sgtin;
  SmartDevice? smartDeviceFocus;

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    qrCodeController.dispose();
    deviceTypeController.dispose();
    smartKeyController.dispose();
    sgtinController.dispose();
    nameController.dispose();
    descriptionController.dispose();
    roomController.dispose();
    floorController.dispose();
    buildingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    smartDeviceFocus = ref.read(smartDeviceFocusProvider);
    if (smartDeviceFocus != null) {
      qrCodeController.text = smartDeviceFocus!.qrCode;
      _valueDeviceType = smartDeviceFocus!.deviceType;
      smartKeyController.text = smartDeviceFocus!.smartKey;
      sgtinController.text = smartDeviceFocus!.sgtin;
      nameController.text = smartDeviceFocus!.name;
      descriptionController.text = smartDeviceFocus!.description;
      _valueRoom = smartDeviceFocus!.room;
      _valueFloor = smartDeviceFocus!.floor;
      buildingController.text = smartDeviceFocus!.building;
      _sgtin = smartDeviceFocus!.sgtin;
    } else {}
    super.initState();
  }

  String? _errorText({required List<String> sgtinList}) {
    // at any time, we can get the text from _controller.value.text
    final text = sgtinController.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Die SGTIN Nummer darf nicht leer sei (ID)';
    }
    if (sgtinList.contains(text)) {
      return 'Achtung: Die SGTIN Nummer (ID) ist bereits vorhanden, ein Speichern überschreibt vorhandene Werte (update)';
    }
    // return null if the text is valid
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<DeviceType>> deviceTypeListAsync =
        ref.watch(deviceTypeListProvider);

    final AsyncValue<List<Room>> roomListAsync = ref.watch(roomListProvider);
    final AsyncValue<List<Floor>> floorListAsync = ref.watch(floorListProvider);
    final AsyncValue<List<Building>> buildingListAsnyc =
        ref.watch(buildingListProvider);

    final AsyncValue<List<String>> sgtinListAsync =
        ref.watch(sgtinNummersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('erstelle / aktualisiere ein SmartDevice'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: ((context) {

                      if (Platform.isWindows) {
                        return AlertDialog(
                          title: const Text('TextField in Dialog'),
                          content: Column(
                            children: [
                              const Text(
                                  'Bei der Verwendung von Windows kann der QR-Code leider nicht direkt gescannt werden. Es wird die Verwendung von Android Smartphones empfohlen. Falls es unbedingt benötigt wird, gibt es auch die Möglichkeit, die Daten manuell einzutragen.'),
                              TextField(
                                controller: qrCodeController,
                                decoration: const InputDecoration(
                                    hintText: "QR-Daten manuell eingeben..."),
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text(
                                'abbrechen',
                                style: TextStyle(color: Colors.red),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            TextButton(
                              child: const Text('ok'),
                              onPressed: () {
                                setState(() {});

                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      } else {

                      return MobileScanner(
                        controller: MobileScannerController(
                            detectionSpeed: DetectionSpeed.noDuplicates),
                        onDetect: (capture) {
                          final List<Barcode> barcodes = capture.barcodes;
                            // debugPrint(barcodes.first.rawValue.toString());
                          setState(() {
                            qrCodeController.text =
                                barcodes.first.rawValue.toString();
                          });
                            Navigator.pop(context);
                        },
                      );
                      }


                    }),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(designBorderRadius),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Text('Scan QR-Code'),
                        Image.asset(
                          'assets/img/qr_image.png',
                          width: 200,
                          height: 200,
                        ),
                        Text(qrCodeController.value.text),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                decoration: const InputDecoration(label: Text('smartKey')),
                controller: smartKeyController,
              ),
              const SizedBox(
                height: 20,
              ),
              sgtinListAsync.when(
                  error: (e, st) => Text(e.toString()),
                  loading: () => const CircularProgressIndicator(),
                  data: (sgtinList) {
                    return TextField(
                        decoration: InputDecoration(
                            label: const Text('SGTIN - Geräte ID'),
                            errorText: _errorText(sgtinList: sgtinList)),
                        controller: sgtinController,
                        // this will cause the widget to rebuild whenever the text changes
                        onChanged: (text) => setState(() => _sgtin = text));
                  }),

              const SizedBox(
                height: 20,
              ),
              TextField(
                decoration: const InputDecoration(label: Text('Name')),
                controller: nameController,
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                decoration: const InputDecoration(label: Text('Beschreibung')),
                controller: descriptionController,
              ),
              const SizedBox(
                height: 50,
              ),
              const Divider(),
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Gerätetyp auswählen',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              deviceTypeListAsync.when(
                  error: (e, st) => Text(e.toString()),
                  loading: () => const CircularProgressIndicator(),
                  data: (deviceTypeList) {
                    return Wrap(
                      spacing: 5.0,
                      children: List<Widget>.generate(
                        deviceTypeList.length,
                        (int index) {
                          return ChoiceChip(
                            label: Text(deviceTypeList[index].name),
                            selected:
                                _valueDeviceType == deviceTypeList[index].name,
                            onSelected: (bool selected) {
                              setState(() {
                                _valueDeviceType = selected
                                    ? deviceTypeList[index].name
                                    : null;
                              });
                            },
                          );
                        },
                      ).toList(),
                    );
                  }),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Raum auswählen',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              roomListAsync.when(
                  error: (e, st) => Text(e.toString()),
                  loading: () => const CircularProgressIndicator(),
                  data: (roomList) {
                    return Wrap(
                      spacing: 5.0,
                      children: List<Widget>.generate(
                        roomList.length,
                        (int index) {
                          return ChoiceChip(
                            label: Text(roomList[index].name),
                            selected: _valueRoom == roomList[index].name,
                            onSelected: (bool selected) {
                              setState(() {
                                _valueRoom =
                                    selected ? roomList[index].name : null;
                              });
                            },
                          );
                        },
                      ).toList(),
                    );
                  }),

              const SizedBox(
                height: 20,
              ),
              const Text(
                'Etage auswählen',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              floorListAsync.when(
                  error: (e, st) => Text(e.toString()),
                  loading: () => const CircularProgressIndicator(),
                  data: (floorList) {
                    return Wrap(
                      spacing: 5.0,
                      children: List<Widget>.generate(
                        floorList.length,
                        (int index) {
                          return ChoiceChip(
                            label: Text(floorList[index].name),
                            selected: _valueFloor == floorList[index].name,
                            onSelected: (bool selected) {
                              setState(() {
                                _valueFloor =
                                    selected ? floorList[index].name : null;
                              });
                            },
                          );
                        },
                      ).toList(),
                    );
                  }),

              const SizedBox(
                height: 20,
              ),

              buildingListAsnyc.when(
                  error: (e, st) => Text(e.toString()),
                  loading: () => const CircularProgressIndicator(),
                  data: (buildingList) {
                    Building building =
                        buildingList.firstWhere((e) => e.isFavorite);
                    buildingController.value =
                        TextEditingValue(text: building.name);
                    return TextField(
                      decoration: const InputDecoration(label: Text('Gebäude')),
                      controller: buildingController,
                    );
                  }),

              const SizedBox(
                height: 20,
              ),

              // only for debug purpose
              // ElevatedButton(
              //     onPressed: () {
              //       SembastApi.updateNullKeys();
              //     },
              //     child: const Text('update null Keys')),


              FilledButton(
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(
                      60), // fromHeight use double.infinity as width and 40 is the height
                ),
                onPressed: _sgtin != null
                    ? _sgtin!.isNotEmpty
                        ? () {
                            final SmartDevice newSmartDevice = SmartDevice(
                                qrCode: qrCodeController.text,
                                deviceType: _valueDeviceType != null
                                    ? _valueDeviceType!
                                    : '',
                                smartKey: smartKeyController.text,
                                sgtin: sgtinController.text,
                                name: nameController.text,
                                description: descriptionController.text,
                                room: _valueRoom != null ? _valueRoom! : '',
                                floor: _valueFloor != null ? _valueFloor! : '',
                                building: buildingController.text);

                            ref
                                .watch(smartDeviceListProvider.notifier)
                                .addSmartDevice(newSmartDevice);
                            Navigator.pop(context);

                            // SembastApi.storeData(ref.watch(smartDeviceFocusProvider))
                            //     .then((value) => Navigator.popUntil(
                            //         context, ModalRoute.withName(HomeScreen.route)));
                          }
                        : null
                    : null,
                child: const Text('speichern'),
              ),

              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
