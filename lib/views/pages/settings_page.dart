import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smart_home_control/models/settings.dart';

import 'package:smart_home_control/views/components/navigation_drawer.dart';
import 'package:smart_home_control/views/components/settings_form.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final submitTrigger = StreamController.broadcast();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SettingsForm(
        submitTrigger: submitTrigger.stream,
      ),
      drawer: const NavigationDrawer(),
      floatingActionButton: FloatingActionButton(
          onPressed: () => submitTrigger.sink.add(null),
          child: const Icon(Icons.check)),
    );
  }
}
