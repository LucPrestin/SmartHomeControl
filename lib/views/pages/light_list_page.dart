import 'package:flutter/material.dart';

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
      body: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          shrinkWrap: false,
          itemCount: 40,
          itemBuilder: (BuildContext context, int index) {
            return LightListItem();
          }),
      drawer: const NavigationDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, Routes.lightsNew),
        child: const Icon(Icons.add),
      ),
    );
  }
}
