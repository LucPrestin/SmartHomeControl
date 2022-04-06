import 'dart:async';

import 'package:flutter/material.dart';

import 'package:smart_home_control/views/forms/settings_form.dart';

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
        centerTitle: true,
        title: const Text('Settings'),
      ),
      body: SettingsForm(submitTrigger: submitTrigger.stream),
      floatingActionButton: FloatingActionButton(
        onPressed: () => submitTrigger.sink.add(null),
        child: const Icon(Icons.check),
      ),
    );
  }
}
