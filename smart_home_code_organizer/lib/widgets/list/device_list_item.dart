import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_home_code_organizer/classes/smart_device_class.dart';
import 'package:smart_home_code_organizer/providers/smart_device_provider.dart';
import 'package:smart_home_code_organizer/screens/add_smart_device_screen.dart';
import 'package:smart_home_code_organizer/screens/detail_view_screen.dart';
import 'package:smart_home_code_organizer/utils/color_calculator.dart';

class DeviceListItem extends ConsumerWidget {
  const DeviceListItem({required this.smartDevice, super.key});

  final SmartDevice smartDevice;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
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

    final last4Sgtin =
        smartDevice.sgtin.substring(smartDevice.sgtin.length - 4);
    final backgroundColor = colorFor(smartDevice.name);
    final foregroundColor =
        backgroundColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;

    String circleText = smartDevice.room.isNotEmpty ? smartDevice.room[0] : "_";
    circleText = circleText +
        (smartDevice.floor.isNotEmpty ? smartDevice.floor[0] : "_");
    circleText = circleText +
        (smartDevice.floor.length >= 2 ? smartDevice.floor[1] : "_");
    circleText = circleText +
        (smartDevice.floor.length >= 4 ? smartDevice.floor[3] : "");

    return ListTile(
      leading: CircleAvatar(
        radius: 24,
        // backgroundColor: Theme.of(context).colorScheme.primary,
        backgroundColor: backgroundColor,
        child: Text(
          circleText,
          // style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          style: TextStyle(color: foregroundColor),
        ),
      ),
      title: Text(smartDevice.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(smartDevice.description),
          Text('${smartDevice.room} / ${smartDevice.floor}'),
        ],
      ),
      trailing: InkWell(
        onTap: () {
          Clipboard.setData(ClipboardData(text: last4Sgtin)).then((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Buchstaben "$last4Sgtin" im Zwischenspeicher.'),
              ),
            );
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text('SGTIN'),
              Text(last4Sgtin),
            ],
          ),
        ),
      ),
      onTap: () {
        ref.read(smartDeviceFocusProvider.notifier).setAllValues(smartDevice);
        Navigator.pushNamed(context, DetailScreen.route);
      },
      onLongPress: () {
        ref.read(smartDeviceFocusProvider.notifier).setAllValues(smartDevice);
        deviceDialog(context, smartDevice, ref);
      },
    );
  }
}
