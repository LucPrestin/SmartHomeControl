import 'package:flutter/material.dart';

import 'package:smart_home_control/views/pages/tab_page.dart';

class AboutPage extends StatefulWidget implements TabPage {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();

  @override
  String get title => 'About';

  @override
  IconData? get floatingActionButtonIcon => null;

  @override
  Function()? get floatingActionButtonPressedCallback => null;

  @override
  IconData get navigationIcon => Icons.info;
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Here goes some text about this app'));
  }
}
