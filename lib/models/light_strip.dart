import 'package:flutter/material.dart';

class LightStrip {
  int? id;
  Color color;
  String name;
  String mqttId;
  bool isOn;

  LightStrip(
      {this.id,
      required this.name,
      this.mqttId = '',
      this.color = Colors.black,
      this.isOn = false});

  static fromMap(Map<String, dynamic> map) {
    return LightStrip(
        id: map['id'],
        name: map['name'],
        mqttId: map['mqttId'],
        color: Color(map['color']),
        isOn: map['isOn'] == 1);
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "color": color.value,
      "name": name,
      "mqttId": mqttId,
      "isOn": isOn ? 1 : 0
    };
  }
}
