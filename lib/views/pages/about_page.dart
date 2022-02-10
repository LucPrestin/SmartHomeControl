import 'package:flutter/material.dart';

import 'package:smart_home_control/views/components/navigation_drawer.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: const Center(child: Text('Here goes some text about this app')),
      drawer: const NavigationDrawer(),
    );
  }
}
