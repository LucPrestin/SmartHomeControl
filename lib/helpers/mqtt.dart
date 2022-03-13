import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:smart_home_control/models/light_strip.dart';
import 'package:smart_home_control/models/settings.dart';

class MQTTHelper {
  MQTTHelper._privateContructor(
      {this.broker, this.mqttId, this.password, this.port});
  static final MQTTHelper instance = MQTTHelper._privateContructor();

  static MqttServerClient? _client;
  Future<MqttServerClient?> get client async =>
      _client ??= await _initializeClient();

  String? broker;
  String? mqttId;
  String? password;
  int? port;

  Future<MqttServerClient?> _initializeClient() async {
    Map<String, String> preferences =
        await const FlutterSecureStorage().readAll();

    broker = preferences[Settings.broker];
    mqttId = preferences[Settings.mqttId];
    password = preferences[Settings.mqttId];
    String? portString = preferences[Settings.port];
    if (portString != null) {
      port = int.parse(portString);
    }

    if (broker != null && mqttId != null && password != null && port != null) {
      return _constructClient(broker!, mqttId!, password!, port!);
    }

    return null;
  }

  MqttServerClient _constructClient(
      String broker, String mqttId, String password, int port) {
    MqttServerClient client = MqttServerClient.withPort(broker, mqttId, port);

    client.logging(on: false);
    client.setProtocolV311();
    client.keepAlivePeriod = 20;

    return client;
  }

  Future<bool> sendStripColor(LightStrip strip) {
    return sendMessage(strip.mqttId, strip.color.toString());
  }

  Future<bool> sendMessage(String topic, String message) async {
    var mClient = await client;
    if (mClient == null) return false;

    try {
      await mClient.connect();
    } on NoConnectionException {
      mClient.disconnect();
    } on SocketException {
      mClient.disconnect();
    }

    if (mClient.connectionStatus!.state == MqttConnectionState.connected) {
      final builder = MqttClientPayloadBuilder();
      builder.addString(message);
      mClient.publishMessage(topic, MqttQos.exactlyOnce, builder.payload!);
      mClient.disconnect();
      return true;
    }

    mClient.disconnect();
    return false;
  }
}
