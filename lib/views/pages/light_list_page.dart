import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smart_home_control/helpers/database.dart';
import 'package:smart_home_control/models/light_strip.dart';
import 'package:smart_home_control/models/settings.dart';

import 'package:smart_home_control/routes/routes.dart';
import 'package:smart_home_control/views/components/light_list_item.dart';
import 'package:smart_home_control/interfaces/tab_page.dart';

class LightListPage extends StatefulWidget implements TabPage {
  const LightListPage({Key? key}) : super(key: key);

  @override
  State<LightListPage> createState() => _LightListPageState();

  @override
  String get title => 'Lights';

  @override
  IconData get tabBarIcon => Icons.lightbulb;

  @override
  String get tabBarText => 'Lights';
}

class _LightListPageState extends State<LightListPage> {
  late String? broker;
  late String? mqttId;
  late int? port;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<LightStrip>>(
            future: DatabaseHelper.instance.getAllLightStrips(),
            builder: buildLightStripListFromSnapshot),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, Routes.lightsNew)
              .then((_) => setState(() {})),
          child: const Icon(Icons.add),
        ));
  }

  Widget buildLightStripListFromSnapshot(context, snapshot) {
    Widget body;
    if (snapshot.hasData) {
      body = buildLightStripList(snapshot.data!);
    } else if (snapshot.hasError) {
      body = Center(
          child: Column(children: [
        const Icon(Icons.error_outline),
        Text(snapshot.error.toString())
      ]));
    } else {
      body = Center(
          child: Column(
        children: const [
          SizedBox(
            width: 80,
            height: 80,
            child: CircularProgressIndicator(),
          ),
          Text('Waiting for database to load the light strips')
        ],
      ));
    }

    return body;
  }

  ListView buildLightStripList(List<LightStrip> strips) {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        shrinkWrap: false,
        itemCount: strips.length,
        itemBuilder: (context, index) {
          final item = strips.elementAt(index);
          return Dismissible(
            key: ObjectKey(item),
            child: LightListItem(item),
            direction: DismissDirection.endToStart,
            dismissThresholds: const {DismissDirection.endToStart: 0.75},
            confirmDismiss: (direction) =>
                showDismissConfirmationDialog(direction, item.name),
            onDismissed: (direction) async {
              setState(() {
                strips.removeAt(index);
              });
              await DatabaseHelper.instance.removeLightStrip(item);
            },
            background: Container(
              color: Colors.red,
              child: const Icon(Icons.delete),
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 8.0),
            ),
          );
        });
  }

  Future<bool?> showDismissConfirmationDialog(
      DismissDirection direction, String name) async {
    return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Delete $name?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () async {
                    Navigator.pop(context, true);
                  },
                  child: const Text('Confirm'))
            ],
          );
        });
  }

  Future loadServerSettingsFromDisk() async {
    Map<String, String> preferences =
        await (const FlutterSecureStorage()).readAll();

    setState(() {
      broker = preferences[Settings.broker];
      mqttId = preferences[Settings.mqttId];
      String? portString = preferences[Settings.port];
      if (portString != null) {
        port = int.parse(portString);
      }
    });
  }
}
