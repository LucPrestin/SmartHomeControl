import 'package:flutter/material.dart';
import 'package:smart_home_control/models/database.dart';
import 'package:smart_home_control/models/light_strip.dart';

import 'package:smart_home_control/routes/routes.dart';
import 'package:smart_home_control/views/components/light_list_item.dart';
import 'package:smart_home_control/views/components/navigation_drawer.dart';

class LightListPage extends StatefulWidget {
  const LightListPage({Key? key}) : super(key: key);

  @override
  State<LightListPage> createState() => _LightListPageState();
}

class _LightListPageState extends State<LightListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lights'),
        ),
        body: FutureBuilder<List<LightStrip>>(
          future: DatabaseHelper.instance.getAllLightStrips(),
          builder: (context, snapshot) {
            Widget body;
            if (snapshot.hasData) {
              var strips = snapshot.data!;
              body = ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  shrinkWrap: false,
                  itemCount: strips.length,
                  itemBuilder: (context, index) =>
                      LightListItem(strips.elementAt(index)));
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
                  Text('Waiting for database to load the light strips')
                ],
              );
            }

            return body;
          },
        ),
        drawer: const NavigationDrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, Routes.lightsNew),
          child: const Icon(Icons.add),
        ));
  }
}
