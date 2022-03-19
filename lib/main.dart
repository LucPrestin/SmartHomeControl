import 'package:flutter/material.dart';
import 'package:smart_home_control/views/pages/light_add_page.dart';
import 'package:smart_home_control/views/pages/light_edit_page.dart';

import 'package:smart_home_control/views/pages/about_page.dart';
import 'package:smart_home_control/views/pages/light_list_page.dart';
import 'package:smart_home_control/views/pages/smart_hub_list_page.dart';

import 'routes/routes.dart';

void main() {
  runApp(const SmartHomeControlApp());
}

class SmartHomeControlApp extends StatelessWidget {
  const SmartHomeControlApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Smart Home Control',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.system,
        home: const LightListPage(),
        routes: {
          Routes.lights: (context) => const LightListPage(),
          Routes.lightsNew: (context) => const LightAddPage(),
          Routes.lightsEdit: (context) => const LightEditPage(),
          Routes.smartHubs: (context) => const SmartHubListPage(),
          Routes.about: (context) => const AboutPage(),
        });
  }
}
