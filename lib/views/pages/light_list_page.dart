import 'package:flutter/material.dart';

import '../components/navigation_drawer.dart';

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
      body: const Center(
          child: Text(
              'Here goes a list of smart lights and a fab to add a new one')),
      drawer: const NavigationDrawer(),
    );
  }
}
