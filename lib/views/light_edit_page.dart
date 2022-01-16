import 'package:flutter/material.dart';
import 'package:smart_home_control/models/lightStrip.dart';
import 'package:smart_home_control/views/light_form.dart';

class LightEditPage extends StatefulWidget {
  const LightEditPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LightEditPageState();
}

class _LightEditPageState extends State<LightEditPage> {
  @override
  Widget build(BuildContext context) {
    final strip = ModalRoute.of(context)!.settings.arguments as LightStrip;

    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Light Strip ${strip.id}'),
        ),
        body: LightForm(
          strip: strip,
        ));
  }
}
