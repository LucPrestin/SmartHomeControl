import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:smart_home_control/models/database.dart';
import 'package:smart_home_control/models/light_strip.dart';

class LightForm extends StatefulWidget {
  const LightForm({Key? key, this.strip}) : super(key: key);

  final LightStrip? strip;

  @override
  State<StatefulWidget> createState() => _LightFormState();
}

class _LightFormState extends State<LightForm> {
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

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: [nameField(), idField(), colorPicker(), submitButton()],
            )));
  }

  TextFormField nameField() {
    return TextFormField(
      key: const Key('field name'),
      decoration: const InputDecoration(
          hintText: 'Where is the light strip located?', labelText: 'Name *'),
      initialValue: name,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a name';
        }
        return null;
      },
    );
  }

  TextFormField idField() {
    return TextFormField(
      key: const Key('field mqttId'),
      decoration: const InputDecoration(
          hintText: 'What is the mqtt id of the strip?',
          labelText: 'MQTT id *'),
      initialValue: mqttId,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter an ID';
        }
        return null;
      },
    );
  }

  SlidePicker colorPicker() {
    return SlidePicker(
      key: const Key('field color'),
      onColorChanged: (Color value) => setState(() => color = value),
      pickerColor: color,
    );
  }

  ElevatedButton submitButton() {
    return ElevatedButton(
        onPressed: () {
          checkAndSubmitForm();
        },
        child: const Text('Submit'));
  }

  void checkAndSubmitForm() {
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
