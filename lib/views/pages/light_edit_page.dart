import 'package:flutter/material.dart';

import 'dart:async';

import 'package:smart_home_control/models/light_strip.dart';
import 'package:smart_home_control/views/forms/light_form.dart';

class LightEditPage extends StatefulWidget {
  const LightEditPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LightEditPageState();
}

class _LightEditPageState extends State<LightEditPage> {
  @override
  Widget build(BuildContext context) {
    final submitTrigger = StreamController.broadcast();
    final strip = ModalRoute.of(context)!.settings.arguments as LightStrip;

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Light Strip ${strip.id}'),
      ),
      body: LightForm(
        strip: strip,
        submitTrigger: submitTrigger.stream,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => submitTrigger.sink.add(null),
        child: const Icon(Icons.check),
      ),
    );
  }
}
