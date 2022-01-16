import 'package:flutter/material.dart';
import 'package:smart_home_control/views/light_form.dart';

class LightAddPage extends StatefulWidget {
  const LightAddPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LightAddPageState();
}

class _LightAddPageState extends State<LightAddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('New Light Strip'),
        ),
        body: const LightForm());
  }
}
