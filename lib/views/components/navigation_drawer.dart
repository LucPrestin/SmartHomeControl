import 'package:flutter/material.dart';

import 'package:smart_home_control/routes/routes.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        SizedBox(
          height: 150,
          child: DrawerHeader(
            decoration:
                BoxDecoration(color: Theme.of(context).colorScheme.secondary),
            child: null,
          ),
        ),
        Expanded(
          child: ListView(
            itemExtent: 40,
            padding: EdgeInsets.zero,
            children: [
              ListTile(
                key: const Key('to LightListPage'),
                leading: const Icon(Icons.lightbulb),
                title: const Text('Lights'),
                onTap: () =>
                    Navigator.pushReplacementNamed(context, Routes.lights),
              ),
              ListTile(
                key: const Key('to SmartHubListPage'),
                leading: const Icon(Icons.device_hub),
                title: const Text('Smart Hubs'),
                onTap: () =>
                    Navigator.pushReplacementNamed(context, Routes.smartHubs),
              ),
              const Divider(),
              ListTile(
                key: const Key('to SettingsPage'),
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () =>
                    Navigator.pushReplacementNamed(context, Routes.settings),
              ),
              ListTile(
                key: const Key('to AboutPage'),
                leading: const Icon(Icons.info),
                title: const Text('About'),
                onTap: () =>
                    Navigator.pushReplacementNamed(context, Routes.about),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
