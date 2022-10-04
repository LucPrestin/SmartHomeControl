import 'package:flutter/material.dart';

class LightStrip {
  static const tableName = 'light_strip';

  int? id;
  Color color;
  String name;
  String mqttTopic;
  bool isOn;

  LightStrip(
      {this.id,
      required this.name,
      this.mqttTopic = '',
      this.color = Colors.black,
      this.isOn = false});

  static fromMap(Map<String, dynamic> map) {
    return LightStrip(
        id: map['id'],
        name: map['name'],
        mqttTopic: map['mqttTopic'],
        color: Color(map['color']),
        isOn: map['isOn'] == 1);
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "color": color.value,
      "name": name,
      "mqttTopic": mqttTopic,
      "isOn": isOn ? 1 : 0
    };
  }
}
