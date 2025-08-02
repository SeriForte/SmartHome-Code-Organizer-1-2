import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_home_code_organizer/classes/building_class.dart';
import 'package:smart_home_code_organizer/classes/device_type_class.dart';
import 'package:smart_home_code_organizer/classes/floor_class.dart';
import 'package:smart_home_code_organizer/classes/room_class.dart';
import 'package:smart_home_code_organizer/providers/building_provider.dart';
import 'package:smart_home_code_organizer/providers/device_type_provider.dart';
import 'package:smart_home_code_organizer/providers/floor_provider.dart';
import 'package:smart_home_code_organizer/providers/room_provider.dart';
import 'package:smart_home_code_organizer/providers/settings_provider.dart';
import 'package:smart_home_code_organizer/utils/constants.dart';
import 'package:smart_home_code_organizer/widgets/settings/attribute_input.dart';
// import 'package:smart_home_code_organizer/widgets/start/link_button.dart';
import 'package:smart_home_code_organizer/widgets/start/link_button2.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});
  static const route = '/settings';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  String? newType;
  String? newFloor;
  String? newRoom;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<String> dbPathAsync = ref.watch(settingsProvider);
    final AsyncValue<List<DeviceType>> deviceTypeListAsync =
        ref.watch(deviceTypeListProvider);
    final AsyncValue<List<Building>> buildingListAsync =
        ref.watch(buildingListProvider);
    final AsyncValue<List<Floor>> floorListAsync = ref.watch(floorListProvider);
    final AsyncValue<List<Room>> roomListAsync = ref.watch(roomListProvider);

    // debugPrint('SettingsScreen build()');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Einstellungen'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: double.infinity,
                height: 10,
              ),
              const Text(
                'Speicherort für Datenbank: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              dbPathAsync.when(
                  error: (e, st) => Text(e.toString()),
                  loading: () => const CircularProgressIndicator(),
                  data: (dbPath) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Clipboard.setData(ClipboardData(text: dbPath))
                                    .then((_) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Pfad "$dbPath" im Zwischenspeicher.')));
                                });
                              },
                              child: const Text('Pfad kopieren:')),
                          const SizedBox(
                            width: 10,
                          ),
                          SelectableText(dbPath),
                        ],
                      ),
                    );
                  }),
              const SizedBox(
                width: double.infinity,
                height: 10,
              ),
              const Divider(),
              const Text(
                'Attribute:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              deviceTypeListAsync.when(
                error: (e, st) => Text(e.toString()),
                loading: () => const CircularProgressIndicator(),
                data: (deviceTypeList) => AttributeInput(
                  title: 'Geträtetypen',
                  attributeList: deviceTypeList
                      .map(
                        (e) => e.name,
                      )
                      .toList(),
                  inputLabel: 'HmIp....',
                  isDeviceType: true,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              floorListAsync.when(
                error: (e, st) => Text(e.toString()),
                loading: () => const CircularProgressIndicator(),
                data: (floorList) => AttributeInput(
                  title: 'Etagen',
                  attributeList: floorList
                      .map(
                        (e) => e.name,
                      )
                      .toList(),
                  inputLabel: 'EG, UG, OG 1 ...',
                  isFloor: true,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              roomListAsync.when(
                error: (e, st) => Text(e.toString()),
                loading: () => const CircularProgressIndicator(),
                data: (roomList) => AttributeInput(
                  title: 'Räume',
                  attributeList: roomList
                      .map(
                        (e) => e.name,
                      )
                      .toList(),
                  inputLabel: 'Küche, Bad, Schlafzimmer ...',
                  isRoom: true,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              buildingListAsync.when(
                error: (e, st) => Text(e.toString()),
                loading: () => const CircularProgressIndicator(),
                data: (List<Building> buildingList) => AttributeInput(
                  title: 'Gebäude',
                  attributeList: buildingList
                      .map(
                        (e) => e.name,
                      )
                      .toList(),
                  inputLabel: 'Hauptstraße 1 ...',
                  isBuilding: true,
                  favorite: buildingList.firstWhere((e) => e.isFavorite).name,
                ),
              ),
              const Divider(),
              const Text(
                'weitere Infos',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const LinkButton2(
                  urlLabel: "Datenschutzrichtlinie ", url: privacyUrl),
              const LinkButton2(
                  urlLabel: "Nutzungsbedingungen ", url: termsOfUseUrl),
                                    
              
              TextButton(
                onPressed: () {
                  showAboutDialog(
                      context: context,
                      applicationVersion: '1.0',
                      applicationLegalese:
                          'Die Nutzungsbedingungen (Terms of Use) und die Datenschutzrichtline (Privacy Policy) sind im Settings-Menu verlinkt.');
                },
                child: const Text('rechtliches & Lizenzen'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
