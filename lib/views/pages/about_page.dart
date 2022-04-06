import 'package:flutter/material.dart';

import 'package:smart_home_control/interfaces/tab_page.dart';

class AboutPage extends StatefulWidget implements TabPage {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();

  @override
  String get title => 'About';

  @override
  IconData get tabBarIcon => Icons.info;

  @override
  String get tabBarText => 'About';
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('About'),
      ),
      body: const Center(child: Text('Here goes some text about this app')),
    );
  }
}
