import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
  String? password;
  int? port;

  Future<bool> saveCurrentPreferences() async {
    const storage = FlutterSecureStorage();

    await Future.wait([
      storage.write(key: Settings.broker, value: broker!),
      storage.write(key: Settings.mqttId, value: mqttId!),
      storage.write(key: Settings.password, value: password!),
      storage.write(key: Settings.port, value: port!.toString())
    ]);

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<Map<String, String>>(
              future: (const FlutterSecureStorage()).readAll(),
              builder: buildFormFromSnapshot)),
      drawer: const NavigationDrawer(),
      floatingActionButton: FloatingActionButton(
          onPressed: () => checkAndSubmit(), child: const Icon(Icons.check)),
    );
  }

  Widget buildFormFromSnapshot(context, snapshot) {
    Widget body;
    if (snapshot.hasData) {
      Map<String, String> preferences = snapshot.data!;

      broker = preferences[Settings.broker];
      mqttId = preferences[Settings.mqttId];
      password = preferences[Settings.mqttId];
      String? portString = preferences[Settings.port];
      if (portString != null) {
        port = int.parse(portString);
      }

      body = buildForm();
    } else if (snapshot.hasError) {
      body = Column(children: [
        const Icon(Icons.error_outline),
        Text(snapshot.error.toString())
      ]);
    } else {
      body = Column(
        children: const [
          SizedBox(
            width: 80,
            height: 80,
            child: CircularProgressIndicator(),
          ),
          Text('Waiting for stored preferences')
        ],
      );
    }

    return body;
  }

  Widget buildForm() {
    return Form(
        key: _formKey,
        child: Column(children: [
          brokerField(),
          spacing(),
          mqttIdField(),
          spacing(),
          passwordField(),
          spacing(),
          portField()
        ]));
  }

  SizedBox spacing() {
    return const SizedBox(height: 20);
  }

  TextFormField brokerField() {
    return TextFormField(
        key: const Key('field broker'),
        onSaved: (String? value) => setState(() => broker = value),
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
            enabledBorder: OutlineInputBorder(),
            disabledBorder: OutlineInputBorder()));
  }

  TextFormField mqttIdField() {
    return TextFormField(
      key: const Key('field mqttId'),
      onSaved: (String? value) => setState(() => mqttId = value),
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
          enabledBorder: OutlineInputBorder(),
          disabledBorder: OutlineInputBorder()),
    );
  }

  TextFormField passwordField() {
    return TextFormField(
      key: const Key('field password'),
      onSaved: (String? value) => setState(() => password = value),
      initialValue: password,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter an ID';
        }
        return null;
      },
      obscureText: true,
      decoration: const InputDecoration(
          hintText: 'The password for this phone on the MQTT broker',
          labelText: 'Password *',
          enabledBorder: OutlineInputBorder(),
          disabledBorder: OutlineInputBorder()),
    );
  }

  TextFormField portField() {
    return TextFormField(
      key: const Key('field port'),
      keyboardType: TextInputType.number,
      onSaved: (String? value) => setState(() {
        if (value != null && value.isNotEmpty) {
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
          enabledBorder: OutlineInputBorder(),
          disabledBorder: OutlineInputBorder()),
    );
  }

  void checkAndSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await saveCurrentPreferences();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Preferences successfully updated')));
    }
  }
}
