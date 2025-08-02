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

class AttributeInput extends ConsumerStatefulWidget {
  const AttributeInput({
    super.key,
    required this.title,
    required this.inputLabel,
    required this.attributeList,
    this.isDeviceType = false,
    this.isFloor = false,
    this.isRoom = false,
    this.isBuilding = false,
    this.favorite = '',
  });

  final String title;
  final String inputLabel;
  final List<String> attributeList;
  final bool isDeviceType;
  final bool isFloor;
  final bool isRoom;
  final bool isBuilding;
  final String favorite;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AttributeInputState();
}

class _AttributeInputState extends ConsumerState<AttributeInput> {
  bool _typeTileExpanded = false;
  String? newname;
  final TextEditingController _attributeController = TextEditingController();

  @override
  void dispose() {
    _attributeController.dispose();
    super.dispose();
  }

  String? _errorText(List<String> filterList, String text) {
    // debugPrint('_errorText filterList= ${filterList.toString()} ');
    // debugPrint('_errorText text= $text ');
    if (text.isEmpty) {
      return 'Der Name darf nicht leer sein.';
    }
    if (filterList.contains(text)) {
      return 'Achtung: Der Name ist bereits vorhanden.';
    }
    // return null if the text is valid
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isBuilding) {
      debugPrint('AttributeInput Widget build()');
      debugPrint(
          'AttributeInput widget.attributeList = ${widget.attributeList}');
      debugPrint('AttributeInput widget.favorite = ${widget.favorite}');
    }

    return ExpansionTile(
        collapsedBackgroundColor: Theme.of(context).colorScheme.primary,
        collapsedTextColor: Theme.of(context).colorScheme.onPrimary,
        collapsedIconColor: Theme.of(context).colorScheme.onPrimary,
        controlAffinity: ListTileControlAffinity.leading,
        onExpansionChanged: (bool expanded) {
          setState(() {
            _typeTileExpanded = expanded;
          });
        },
        title: Text(widget.title),
        subtitle: _typeTileExpanded
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                              controller: _attributeController,
                              decoration: InputDecoration(
                                  label: Text(widget.inputLabel),
                                  errorText: _errorText(widget.attributeList,
                                      _attributeController.value.text)),
                              // this will cause the widget to rebuild whenever the text changes
                              onChanged: (text) =>
                                  setState(() => newname = text)),
                        ),
                        IconButton(
                            onPressed: () async {
                              if (widget.isDeviceType) {
                                await ref
                                    .read(deviceTypeListProvider.notifier)
                                    .addDeviceType(DeviceType(
                                        name: _attributeController.value.text));
                              }
                              if (widget.isFloor) {
                                await ref
                                    .read(floorListProvider.notifier)
                                    .addFloor(Floor(
                                        name: _attributeController.value.text));
                              }
                              if (widget.isRoom) {
                                await ref
                                    .read(roomListProvider.notifier)
                                    .addRoom(Room(
                                        name: _attributeController.value.text));
                              }
                              if (widget.isBuilding) {
                                await ref
                                    .read(buildingListProvider.notifier)
                                    .addBuilding(Building(
                                        name: _attributeController.value.text));
                              }
                              _attributeController.clear();
                            },
                            icon: const Icon(Icons.add))
                      ],
                    ),
                    const Text(
                      'Hinweis: Das Löschen hat keine Auswirkung auf die SmartDevice Datensätze sondern limitiert nur die Auswahl beim Editieren oder Hinzufügen',
                      style: TextStyle(color: Colors.black87, fontSize: 10),
                    ),
                  ])
            : const Text('hinzufügen oder löschen'),
        children: widget.attributeList
            .map(
              (e) => ListTile(
                leading: widget.isBuilding
                    ? IconButton(
                        onPressed: () async {
                          await ref
                              .read(buildingListProvider.notifier)
                              .toggleFavorit(
                                  Building(name: e, isFavorite: true));
                        },
                        icon: Icon(widget.favorite == e
                            ? Icons.star
                            : Icons.star_border))
                    : null,
                title: Text(e),
                trailing: IconButton(
                    onPressed: () async {
                      if (widget.isDeviceType) {
                        await ref
                            .read(deviceTypeListProvider.notifier)
                            .deleteDeviceType(DeviceType(name: e));
                      }
                      if (widget.isFloor) {
                        await ref
                            .read(floorListProvider.notifier)
                            .deleteFloor(Floor(name: e));
                      }
                      if (widget.isRoom) {
                        await ref
                            .read(roomListProvider.notifier)
                            .deleteRoom(Room(name: e));
                      }
                      if (widget.isBuilding) {
                        await ref
                            .read(buildingListProvider.notifier)
                            .deleteBuilding(Building(name: e));
                      }
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    )),
              ),
            )
            .toList());
  }
}
