import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:smart_home_control/models/database.dart';
import 'package:smart_home_control/models/light_strip.dart';
import 'package:smart_home_control/routes/routes.dart';

class LightListItem extends StatefulWidget {
  final LightStrip strip;

  const LightListItem(this.strip, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LightListItemState();
}

class _LightListItemState extends State<LightListItem> {
  late Color stripColor;

  @override
  void initState() {
    super.initState();

    stripColor = widget.strip.color;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[names(), colorBox(), onOffToggle(), editButton()]);
  }

  Column names() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.strip.name,
            style: const TextStyle(color: Color(0xFF000000)),
          ),
          Text(
            widget.strip.mqttId,
            style: const TextStyle(color: Color(0xFF9d9d9d)),
          )
        ]);
  }

  GestureDetector colorBox() {
    return GestureDetector(
        onTap: () async {
          var result = await showColorPickerDialog();
          if (result != null) {
            widget.strip.color = result;
            await DatabaseHelper.instance.updateLightStrip(widget.strip);
            setState(() {});
          }
        },
        child: SizedBox(
            width: 40,
            height: 40,
            child: DecoratedBox(
                decoration: BoxDecoration(
                    color: widget.strip.color,
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(4.0)))));
  }

  Switch onOffToggle() {
    return Switch(
        onChanged: (value) async {
          widget.strip.isOn = value;
          await DatabaseHelper.instance.updateLightStrip(widget.strip);
          setState(() {});
        },
        value: widget.strip.isOn);
  }

  IconButton editButton() {
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: () => Navigator.pushNamed(context, Routes.lightsEdit,
              arguments: widget.strip)
          .then((_) => setState(() {})),
      iconSize: 28.0,
      color: const Color(0xFF9d9d9d),
    );
  }

  Future<Color?> showColorPickerDialog() => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
              child: SlidePicker(
            pickerColor: widget.strip.color,
            onColorChanged: (newColor) {
              setState(() => stripColor = newColor);
            },
          )),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel')),
            TextButton(
                onPressed: () async {
                  Navigator.pop(context, stripColor);
                },
                child: const Text('Confirm'))
          ],
        );
      });
}
