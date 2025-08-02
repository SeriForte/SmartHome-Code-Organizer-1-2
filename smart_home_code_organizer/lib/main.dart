import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_home_code_organizer/screens/add_smart_device_screen.dart';
import 'package:smart_home_code_organizer/screens/detail_view_screen.dart';
import 'package:smart_home_code_organizer/screens/filter_screen.dart';
import 'package:smart_home_code_organizer/screens/home_list_screen.dart';
import 'package:smart_home_code_organizer/screens/home_screen.dart';
import 'package:smart_home_code_organizer/screens/list_smart_device_screen.dart';
import 'package:smart_home_code_organizer/screens/scan_code_screen.dart';
import 'package:smart_home_code_organizer/screens/settings_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}



class App extends StatelessWidget {
  // ignore: use_super_parameters
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Home Code Organizer',
      debugShowCheckedModeBanner: false,

    
      routes: {
        HomeListScreen.route: (context) => const HomeListScreen(),
        HomeScreen.route: (context) => const HomeScreen(),
        AddSmartDeviceScreen.route: (context) => const AddSmartDeviceScreen(),
        ListSmartDeviceScreen.route: (context) => const ListSmartDeviceScreen(),
        FilterScreen.route: (context) => const FilterScreen(),
        SettingsScreen.route: (context) => const SettingsScreen(),
        ScanCodeScreen.route: (context) => const ScanCodeScreen(),
        DetailScreen.route: (context) => const DetailScreen(),
      },
    );
  }
}
