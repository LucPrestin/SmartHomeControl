import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'dart:async';

import 'package:smart_home_control/helpers/database.dart';
import 'package:smart_home_control/models/light_strip.dart';
import 'package:smart_home_control/views/forms/form_with_submit_trigger.dart';

class LightForm extends FormWithSubmitTrigger {
  const LightForm({Key? key, this.strip, @required submitTrigger})
      : super(key: key, submitTrigger: submitTrigger);

  final LightStrip? strip;

  @override
  State<StatefulWidget> createState() => _LightFormState();
}

class _LightFormState extends FormWithSubmitTriggerState<LightForm> {
  late bool isEditForm;

  late String? name;
  late String? mqttTopic;
  late Color? color;
  late int? id;

  @override
  void initState() {
    super.initState();

    isEditForm = widget.strip == null ? false : true;

    name = widget.strip?.name;
    mqttTopic = widget.strip?.mqttTopic;
    color = widget.strip?.color;
    id = widget.strip?.id;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: formKey,
            child: SingleChildScrollView(
                child: Column(
              children: [
                _nameField(),
                _spacing(),
                _mqttIdField(),
                _spacing(),
                _colorPicker(),
                _spacing()
              ],
            ))));
  }

  SizedBox _spacing() {
    return const SizedBox(height: 20);
  }

  TextFormField _nameField() {
    return TextFormField(
        key: const Key('field name'),
        onSaved: (String? value) => setState(() => name = value),
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

  TextFormField _mqttIdField() {
    return TextFormField(
      key: const Key('field mqttId'),
      onSaved: (String? value) => setState(() => mqttTopic = value),
      initialValue: mqttTopic,
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

  Container _colorPicker() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
      child: SlidePicker(
        key: const Key('field color'),
        onColorChanged: (Color value) => setState(() => color = value),
        pickerColor: color ?? Colors.black,
      ),
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(4)),
    );
  }

  @override
  Future<void> onSave() async {
    if (isEditForm) {
      widget.strip!.color = color ?? Colors.black;
      widget.strip!.name = name ?? '';
      widget.strip!.mqttTopic = mqttTopic ?? '';
      await DatabaseHelper.instance.updateLightStrip(widget.strip!);
    } else {
      await DatabaseHelper.instance.insertLightStrip(LightStrip(
          id: id,
          name: name ?? '',
          mqttTopic: mqttTopic ?? '',
          color: color ?? Colors.black,
          isOn: false));
    }
    Navigator.pop(context);
  }
}
