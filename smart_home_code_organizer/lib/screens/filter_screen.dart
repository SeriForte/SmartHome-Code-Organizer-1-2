import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_home_code_organizer/classes/device_type_class.dart';
import 'package:smart_home_code_organizer/classes/floor_class.dart';
import 'package:smart_home_code_organizer/classes/room_class.dart';
import 'package:smart_home_code_organizer/providers/device_type_provider.dart';
import 'package:smart_home_code_organizer/providers/floor_provider.dart';
import 'package:smart_home_code_organizer/providers/room_provider.dart';
import 'package:smart_home_code_organizer/providers/smart_device_provider.dart';

class FilterScreen extends ConsumerStatefulWidget {
  const FilterScreen({super.key});
  static const route = '/filter';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FilterScreenState();
}

class _FilterScreenState extends ConsumerState<FilterScreen> {

  List<String> _typeFilterList = [];
  List<String> _floorFilterList = [];
  List<String> _roomFilterList = [];
  List<String> _completeFilterList = [];

  @override
  void initState() {
    _typeFilterList = ref.read(deviceTypeFilterProvider);
    _floorFilterList = ref.read(floorFilterProvider);
    _roomFilterList = ref.read(roomFilterProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    final AsyncValue<List<DeviceType>> deviceTypeListAsync =
        ref.watch(deviceTypeListProvider);
    final AsyncValue<List<Floor>> floorListAsync = ref.watch(floorListProvider);
    final AsyncValue<List<Room>> roomListAsync = ref.watch(roomListProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              _completeFilterList = ref
                  .read(deviceTypeFilterProvider.notifier)
                  .setList(_typeFilterList);
              _completeFilterList = ref
                  .read(floorFilterProvider.notifier)
                  .setList(_floorFilterList);
              _completeFilterList = ref
                  .read(roomFilterProvider.notifier)
                  .setList(_roomFilterList);
              ref.read(smartDeviceFilterListProvider.notifier).applyFilter();

              debugPrint(
                  'Hey, die neuen Werte sind : ${_completeFilterList.toString()}');
              Navigator.pop(context);
            }),
        title: const Text('Filter'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ExpansionTile(
              collapsedBackgroundColor: Theme.of(context).colorScheme.primary,
              collapsedTextColor: Theme.of(context).colorScheme.onPrimary,
              collapsedIconColor: Theme.of(context).colorScheme.onPrimary,
              title: const Text('Gerätetypen'),
              subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Aktuelle Filter: ${_typeFilterList.toList()}'),
                    const Text('Filter die Geäte nach Typen (und-Verknüpft)'),
                  ]),
              controlAffinity: ListTileControlAffinity.leading,
              children: deviceTypeListAsync.when(
                error: (e, st) => [Text(e.toString())],
                loading: () => [const CircularProgressIndicator()],
                data: (deviceTypeList) => deviceTypeList.map(
                  (e) {
                    String name = e.name;
                    bool val = _typeFilterList.contains(name);
                    return CheckboxListTile(
                      title: Text(name),
                      value: val,
                      onChanged: (val) {
                        setState(() {
                          if (val == true) {
                            _typeFilterList.add(name);
                          } else {
                            _typeFilterList.remove(name);
                          }
                        });
                      },
                    );
                  },
                ).toList(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ExpansionTile(
                collapsedBackgroundColor: Theme.of(context).colorScheme.primary,
                collapsedTextColor: Theme.of(context).colorScheme.onPrimary,
                collapsedIconColor: Theme.of(context).colorScheme.onPrimary,
                title: const Text('Etagen'),
                subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Aktuelle Filter: ${_floorFilterList.toList()}'),
                      const Text(
                          'Filter die Geäte nach Etagen (und-Verknüpft)'),
                    ]),
                controlAffinity: ListTileControlAffinity.leading,
                children: floorListAsync.when(
                  error: (e, st) => [Text(e.toString())],
                  loading: () => [const CircularProgressIndicator()],
                  data: (floorList) => floorList.map(
                    (e) {
                      String name = e.name;
                      bool val = _floorFilterList.contains(name);
                      return CheckboxListTile(
                        title: Text(name),
                        value: val,
                        onChanged: (val) {
                          setState(() {
                            if (val == true) {
                              _floorFilterList.add(name);
                            } else {
                              _floorFilterList.remove(name);
                            }
                          });
                        },
                      );
                    },
                  ).toList(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ExpansionTile(
                collapsedBackgroundColor: Theme.of(context).colorScheme.primary,
                collapsedTextColor: Theme.of(context).colorScheme.onPrimary,
                collapsedIconColor: Theme.of(context).colorScheme.onPrimary,
                title: const Text(
                  'Räume',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Aktuelle Filter: ${_roomFilterList.toList()}'),
                      const Text(
                          'Filter die Geäte nach Räumen (und-Verknüpft)'),
                    ]),
                controlAffinity: ListTileControlAffinity.leading,
                children: roomListAsync.when(
                  error: (e, st) => [Text(e.toString())],
                  loading: () => [const CircularProgressIndicator()],
                  data: (roomList) => roomList.map(
                    (e) {
                      String name = e.name;
                      bool val = _roomFilterList.contains(name);
                      return CheckboxListTile(
                        title: Text(name),
                        value: val,
                        onChanged: (val) {
                          setState(() {
                            if (val == true) {
                              _roomFilterList.add(name);
                            } else {
                              _roomFilterList.remove(name);
                            }
                          });
                        },
                      );
                    },
                  ).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
