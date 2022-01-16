import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:smart_home_control/models/database.dart';
import 'package:smart_home_control/models/lightStrip.dart';

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
  late Color color;
  late int? id;
  late bool isOn;

  @override
  void initState() {
    isEditForm = widget.strip == null ? true : false;

    name = widget.strip?.name ?? '';
    color = widget.strip?.color ?? Colors.black;
    id = widget.strip?.id;
    isOn = widget.strip?.isOn ?? false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [nameField(), colorPicker(), submitButton()],
        ));
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

  ColorPicker colorPicker() {
    return ColorPicker(
      key: const Key('field color'),
      onColorChanged: (Color value) => setState(() => color = value),
      pickerColor: color,
    );
  }

  ElevatedButton submitButton() {
    return ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            var result =
                LightStrip(id: id, name: name, color: color, isOn: isOn);
            if (isEditForm) {
              DatabaseHelper.instance.updateLightStrip(result);
            } else {
              DatabaseHelper.instance.insertLightStrip(result);
            }
            Navigator.pop(context);
          }
        },
        child: const Text('Submit'));
  }
}
