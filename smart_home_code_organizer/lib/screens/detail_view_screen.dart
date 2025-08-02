import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_home_code_organizer/classes/smart_device_class.dart';
import 'package:smart_home_code_organizer/providers/smart_device_provider.dart';
import 'package:smart_home_code_organizer/screens/add_smart_device_screen.dart';

class DetailScreen extends ConsumerWidget {
  const DetailScreen({super.key});

  static const route = '/detail';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SmartDevice? smartDevice = ref.watch(smartDeviceFocusProvider);

    if (smartDevice == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Fehler'),
        ),
        body: const Center(
          child: Text(
              'Es ist ein Fehler aufgetreten, bitte starten Sie den Vorgang erneut'),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(smartDevice.name),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: double.infinity,
                ),
                Text(smartDevice.description),
                Text(smartDevice.deviceType),
                Row(
                  children: [
                    const Text('SGTIN:'),
                    const SizedBox(width: 5),
                    SelectableText(smartDevice.sgtin),
                  ],
                ),
                Row(
                  children: [
                    const Text('Key:'),
                    const SizedBox(width: 5),
                    SelectableText(smartDevice.smartKey),
                  ],
                ),
                Text(smartDevice.room),
                Text(smartDevice.floor),
                Text(smartDevice.building),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text(smartDevice.name),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('Gerät wirklich löschen?',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
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
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('abbrechen'),
                              ),
                            ],
                          ),
                        );

                        Navigator.pop(context);
                      },
                      child: const Text(
                        'löschen',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.popAndPushNamed(
                          context,
                          AddSmartDeviceScreen.route,
                        );
                      },
                      child: const Text(
                        'bearbeiten',
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }
  }
}
