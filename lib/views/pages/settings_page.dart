import 'package:flutter/material.dart';

import 'package:smart_home_control/views/components/navigation_drawer.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: const Center(
          child:
              Text('Here go some options mainly to configure the mqtt server')),
      drawer: const NavigationDrawer(),
    );
  }
}
