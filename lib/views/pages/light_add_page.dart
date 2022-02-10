import 'package:flutter/material.dart';

import 'dart:async';

import 'package:smart_home_control/views/components/light_form.dart';

class LightAddPage extends StatefulWidget {
  const LightAddPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LightAddPageState();
}

class _LightAddPageState extends State<LightAddPage> {
  final submitTrigger = StreamController.broadcast();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Light Strip'),
      ),
      body: LightForm(submitTrigger: submitTrigger.stream),
      floatingActionButton: FloatingActionButton(
        onPressed: () => submitTrigger.sink.add(null),
        child: const Icon(Icons.check),
      ),
    );
  }
}
