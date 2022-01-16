import 'package:flutter/material.dart';

import 'navigation_drawer.dart';

class SmartHubListPage extends StatefulWidget {
  const SmartHubListPage({Key? key}) : super(key: key);

  @override
  State<SmartHubListPage> createState() => _SmartHubListPageState();
}

class _SmartHubListPageState extends State<SmartHubListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Hubs'),
      ),
      body: const Center(
          child: Text(
              'Here goes a list of added smart hubs and a fab to add a new one')),
      drawer: const NavigationDrawer(),
    );
  }
}
