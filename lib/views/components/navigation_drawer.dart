import 'package:flutter/material.dart';

import '../routes/routes.dart';

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
                leading: const Icon(Icons.lightbulb),
                title: const Text('Lights'),
                onTap: () =>
                    Navigator.pushReplacementNamed(context, Routes.lights),
              ),
              ListTile(
                leading: const Icon(Icons.device_hub),
                title: const Text('Smart Hubs'),
                onTap: () =>
                    Navigator.pushReplacementNamed(context, Routes.smartHubs),
              ),
              const Divider(),
              ListTile(
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
