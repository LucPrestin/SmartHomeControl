import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'dart:async';

import 'package:smart_home_control/models/database.dart';
import 'package:smart_home_control/models/light_strip.dart';

class LightForm extends StatefulWidget {
  const LightForm({Key? key, this.strip, this.submitTrigger}) : super(key: key);

  final LightStrip? strip;
  final Stream? submitTrigger;

  @override
  State<StatefulWidget> createState() => _LightFormState();
}

class _LightFormState extends State<LightForm> {
  late StreamSubscription streamSubscription;

  final _formKey = GlobalKey<FormState>();
  late bool isEditForm;

  late String name;
  late String mqttId;
  late Color color;
  late int? id;
  late bool isOn;

  @override
  void initState() {
    isEditForm = widget.strip == null ? true : false;

    name = widget.strip?.name ?? '';
    mqttId = widget.strip?.name ?? '';
    color = widget.strip?.color ?? Colors.black;
    id = widget.strip?.id;
    isOn = widget.strip?.isOn ?? false;

    streamSubscription = widget.submitTrigger!.listen((_) => checkAndSubmit());

    super.initState();
  }

  @override
  didUpdateWidget(LightForm old) {
    super.didUpdateWidget(old);
    // in case the stream instance changed, subscribe to the new one
    if (widget.submitTrigger != old.submitTrigger) {
      streamSubscription.cancel();
      streamSubscription =
          widget.submitTrigger!.listen((_) => checkAndSubmit());
    }
  }

  @override
  dispose() {
    super.dispose();
    streamSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                nameField(),
                spacing(),
                idField(),
                spacing(),
                colorPicker(),
                spacing()
              ],
            )));
  }

  SizedBox spacing() {
    return const SizedBox(height: 20);
  }

  TextFormField nameField() {
    return TextFormField(
        key: const Key('field name'),
        initialValue: name,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a name';
          }
          return null;
        },
        decoration: const InputDecoration(
            hintText: 'Where is the light strip located?',
            labelText: 'Name *',
            enabledBorder: OutlineInputBorder()));
  }

  TextFormField idField() {
    return TextFormField(
      key: const Key('field mqttId'),
      initialValue: mqttId,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter an ID';
        }
        return null;
      },
      decoration: const InputDecoration(
          hintText: 'What is the mqtt id of the strip?',
          labelText: 'MQTT id *',
          enabledBorder: OutlineInputBorder()),
    );
  }

  Container colorPicker() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
      child: SlidePicker(
        key: const Key('field color'),
        onColorChanged: (Color value) => setState(() => color = value),
        pickerColor: color,
      ),
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(4)),
    );
  }

  void checkAndSubmit() {
    if (_formKey.currentState!.validate()) {
      var result = LightStrip(id: id, name: name, color: color, isOn: isOn);
      if (isEditForm) {
        DatabaseHelper.instance.updateLightStrip(result);
      } else {
        DatabaseHelper.instance.insertLightStrip(result);
      }
      Navigator.pop(context);
    }
  }
}
