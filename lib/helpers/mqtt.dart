import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:smart_home_control/constants.dart';
import 'package:smart_home_control/helpers/utils.dart';
import 'package:smart_home_control/models/light_strip.dart';
import 'package:smart_home_control/models/settings.dart';
import 'package:typed_data/typed_buffers.dart';

class MQTTHelper {
  MQTTHelper._privateConstructor(
      {this.broker, this.mqttId, this.password, this.port});
  static final MQTTHelper instance = MQTTHelper._privateConstructor();

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
    password = preferences[Settings.password];
    String? portString = preferences[Settings.port];
    if (portString != null) {
      port = int.parse(portString);
    }
    String? deviceName = await getDeviceName();
    String name;
    if (deviceName != null) {
      name = deviceName;
    } else {
      name = "smart_home_control";
    }

    if (broker != null && password != null && port != null) {
      return _constructClient(broker!, name, password!, port!);
    }

    return null;
  }

  MqttServerClient _constructClient(
      String broker, String deviceName, String password, int port) {
    MqttServerClient client =
        MqttServerClient.withPort(broker, deviceName, port);

    client.logging(on: false);
    client.setProtocolV311();
    client.keepAlivePeriod = 20;

    return client;
  }

  Future<String?> sendStripColor(LightStrip strip) {
    final builder = MqttClientPayloadBuilder();
    builder.addInt(strip.color.value);
    return sendPayload(strip.mqttId + colorSuffix, builder.payload!);
  }

  Future<String?> sendPayload(String topic, Uint8Buffer payload) async {
    var mClient = await client;

    String? errorMessage;

    if (mClient == null) {
      return "Cannot start client. Check the broker address and port.";
    }

    try {
      await mClient.connect(mqttId, password);
    } on NoConnectionException {
      errorMessage = "Cannot connect to broker. Check your name and password.";
      mClient.disconnect();
    } on SocketException {
      // this should never trigger, as we don't use sockets, but just to be safe...
      errorMessage = "Cannot create socket.";
      mClient.disconnect();
    }

    if (mClient.connectionStatus!.state == MqttConnectionState.connected) {
      mClient.publishMessage(topic, MqttQos.atLeastOnce, payload);
    }

    mClient.disconnect();
    return errorMessage;
  }

  Future<Map<String, bool>> sendMessages(Map<String, String> messages) async {
    var mClient = await client;

    var results = <String, bool>{};
    messages.forEach((topic, message) {
      results[topic] = false;
    });

    if (mClient == null) return results;

    try {
      await mClient.connect(mqttId, password);
    } on NoConnectionException {
      mClient.disconnect();
    } on SocketException {
      mClient.disconnect();
    }

    messages.forEach((topic, message) {
      if (mClient.connectionStatus!.state == MqttConnectionState.connected) {
        final builder = MqttClientPayloadBuilder();
        builder.addString(message);
        mClient.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
        results[topic] = true;
      }
    });

    mClient.disconnect();
    return results;
  }
}
