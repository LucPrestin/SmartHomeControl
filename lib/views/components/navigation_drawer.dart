import 'package:flutter/material.dart';

import 'package:smart_home_control/routes/routes.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
            child: Text('Smart Home Control',
                style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).colorScheme.onSurface))),
        ListTile(
          key: const Key('to SettingsPage'),
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          onTap: () => Navigator.pushNamed(context, Routes.settings),
        ),
        ListTile(
          key: const Key('to AboutPage'),
          leading: const Icon(Icons.info),
          title: const Text('About'),
          onTap: () => Navigator.pushNamed(context, Routes.about),
        ),
      ],
    ));
  }
}
