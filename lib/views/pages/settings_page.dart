import 'dart:async';

import 'package:flutter/material.dart';

import 'package:smart_home_control/views/components/navigation_drawer.dart';
import 'package:smart_home_control/views/forms/settings_form.dart';
import 'package:smart_home_control/views/pages/tab_page.dart';

class SettingsPage extends StatefulWidget implements TabPage {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();

  @override
  String get title => 'Settings';

  @override
  IconData? get floatingActionButtonIcon => Icons.check;

  @override
  // TODO: implement
  Function()? get floatingActionButtonPressedCallback => () {
        // TODO: find out how to call this on the state:
        // submitTrigger.sink.add(null)
      };

  @override
  IconData get navigationIcon => Icons.settings;
}

class _SettingsPageState extends State<SettingsPage> {
  final submitTrigger = StreamController.broadcast();

  @override
  Widget build(BuildContext context) {
    return SettingsForm(
      submitTrigger: submitTrigger.stream,
    );
  }
}
