import 'package:flutter/material.dart';
import 'package:smart_home_control/views/about_page.dart';
import 'package:smart_home_control/views/light_add_page.dart';
import 'package:smart_home_control/views/light_form.dart';
import 'package:smart_home_control/views/smart_hub_list_page.dart';

import 'views/light_list_page.dart';
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
        theme: ThemeData(
          colorScheme: ColorScheme(
            primary: Colors.purple.shade400,
            primaryVariant: Colors.purple.shade700,
            secondary: Colors.cyan.shade400,
            secondaryVariant: Colors.cyan.shade700,
            error: const Color.fromRGBO(0xB0, 0x00, 0x20, 1),
            surface: Colors.white,
            background: Colors.white,
            brightness: Brightness.light,
            onPrimary: Colors.white,
            onSecondary: Colors.black,
            onError: Colors.white,
            onSurface: Colors.black,
            onBackground: Colors.black,
          ),
        ),
        home: const LightListPage(),
        routes: {
          Routes.lights: (context) => const LightListPage(),
          Routes.lightsNew: (context) => const LightAddPage(),
          Routes.smartHubs: (context) => const SmartHubListPage(),
          Routes.about: (coutext) => const AboutPage()
        });
  }
}
