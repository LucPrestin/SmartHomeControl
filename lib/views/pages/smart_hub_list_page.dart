import 'package:flutter/material.dart';

import 'package:smart_home_control/interfaces/tab_page.dart';

class SmartHubListPage extends StatefulWidget implements TabPage {
  const SmartHubListPage({Key? key}) : super(key: key);

  @override
  State<SmartHubListPage> createState() => _SmartHubListPageState();

  @override
  String get title => 'Smart Hubs';

  @override
  IconData get tabBarIcon => Icons.device_hub;

  @override
  String get tabBarText => 'Smart Hubs';
}

class _SmartHubListPageState extends State<SmartHubListPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
            'Here goes a list of added smart hubs and a fab to add a new one'));
  }
}
