import 'package:flutter/material.dart';

class LightStrip {
  int id;
  Color color;
  String name;
  bool isOn;

  LightStrip(
      {required this.id,
      required this.name,
      this.color = Colors.black,
      this.isOn = false});

  static fromMap(Map<String, dynamic> map) {
    return LightStrip(
        id: map['id'],
        name: map['name'],
        color: Color(map['color']),
        isOn: map['isOn'] == 1);
  }

  Map<String, dynamic> toMap() {
    return {"id": id, "color": color.value, "name": name, "isOn": isOn ? 1 : 0};
  }
}
