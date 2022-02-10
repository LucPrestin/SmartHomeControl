import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_home_control/models/settings.dart';

import 'package:smart_home_control/views/components/navigation_drawer.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _formKey = GlobalKey<FormState>();

  String? broker;
  String? mqttId;
  int? port;

  @override
  void initState() {
    super.initState();

    loadCurrentPreferences();
  }

  Future loadCurrentPreferences() async {
    final preferences = await SharedPreferences.getInstance();

    setState(() {
      broker = preferences.getString(Settings.broker);
      mqttId = preferences.getString(Settings.mqttId);
      port = preferences.getInt(Settings.port);
    });
  }

  Future<bool> saveCurrentPreferences() async {
    final preferences = await SharedPreferences.getInstance();

    final successes = await Future.wait([
      preferences.setString(Settings.broker, broker!),
      preferences.setString(Settings.mqttId, mqttId!),
      preferences.setInt(Settings.port, port!)
    ]);

    return !successes.contains(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              key: _formKey,
              child: Column(children: [
                brokerField(),
                spacing(),
                mqttIdField(),
                spacing(),
                portField()
              ]))),
      drawer: const NavigationDrawer(),
      floatingActionButton: FloatingActionButton(
          onPressed: () => checkAndSubmit(), child: const Icon(Icons.check)),
    );
  }

  SizedBox spacing() {
    return const SizedBox(height: 20);
  }

  TextFormField brokerField() {
    return TextFormField(
        key: const Key('field broker'),
        onChanged: (String value) => setState(() => broker = value),
        initialValue: broker,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'broker ip cannot be empty';
          }
          return null;
        },
        decoration: const InputDecoration(
            hintText: 'What is the ip-adress of your broker?',
            labelText: 'Broker *',
            enabledBorder: OutlineInputBorder()));
  }

  TextFormField mqttIdField() {
    return TextFormField(
      key: const Key('field mqttId'),
      onChanged: (String value) => setState(() => mqttId = value),
      initialValue: mqttId,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter an ID';
        }
        return null;
      },
      decoration: const InputDecoration(
          hintText: 'How should your phone be called?',
          labelText: 'MQTT id *',
          enabledBorder: OutlineInputBorder()),
    );
  }

  TextFormField portField() {
    return TextFormField(
      key: const Key('field port'),
      keyboardType: TextInputType.number,
      onChanged: (String value) => setState(() {
        if (value.isNotEmpty) {
          port = int.parse(value);
        }
      }),
      initialValue: port?.toString(),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a port';
        }
        return null;
      },
      decoration: const InputDecoration(
          hintText: 'What port does your broker use?',
          labelText: 'Port *',
          enabledBorder: OutlineInputBorder()),
    );
  }

  void checkAndSubmit() async {
    if (_formKey.currentState!.validate()) {
      SnackBar snackBar;

      if (await saveCurrentPreferences()) {
        snackBar =
            const SnackBar(content: Text('Preferences successfully updated'));
      } else {
        snackBar = const SnackBar(
            content:
                Text('Something went wrong when updating the preferences'));
      }

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
