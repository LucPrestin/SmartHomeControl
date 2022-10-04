import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:smart_home_control/constants.dart';
import 'package:smart_home_control/models/light_strip.dart';
import 'package:smart_home_control/models/settings.dart';
import 'package:typed_data/typed_buffers.dart';

class MQTTHelper {
  MQTTHelper._privateConstructor();
  static final MQTTHelper instance = MQTTHelper._privateConstructor();

  Future<MqttServerClient?> get client async {
    Map<String, String> preferences =
        await const FlutterSecureStorage().readAll();

    String? broker = preferences[Settings.broker];
    String? mqttId = preferences[Settings.mqttId];
    String? portString = preferences[Settings.port];
    int? port;
    if (portString != null) {
      port = int.parse(portString);
    }

    if (broker != null && mqttId != null && port != null) {
      MqttServerClient client = MqttServerClient.withPort(broker, mqttId, port);

      client.logging(on: false);
      client.setProtocolV311();
      client.keepAlivePeriod = 20;

      return client;
    }

    return null;
  }

  Future<String?> sendStripColor(LightStrip strip) {
    final builder = MqttClientPayloadBuilder();
    builder.addInt(strip.color.value);
    return sendPayload(strip.mqttTopic + colorSuffix, builder.payload!);
  }

  Future<String?> sendPayload(String topic, Uint8Buffer payload) async {
    var mClient = await client;

    if (mClient == null) {
      return "Cannot start client. Check the broker address and port.";
    }

    var storage = const FlutterSecureStorage();
    String? mqttId = await storage.read(key: Settings.mqttId);
    String? password = await storage.read(key: Settings.password);

    String? errorMessage;

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

  Future<Map<String, bool>> sendStripColors(List<LightStrip> strips) async {
    var payloads = <String, Uint8Buffer>{};
    for (var strip in strips) {
      payloads[strip.mqttTopic] =
          MqttClientPayloadBuilder().addInt(strip.color.value).payload!;
    }
    return sendPayloads(payloads);
  }

  Future<Map<String, bool>> sendPayloads(
      Map<String, Uint8Buffer> messages) async {
    var mClient = await client;

    var results = <String, bool>{};
    messages.forEach((topic, message) {
      results[topic] = false;
    });

    if (mClient == null) return results;

    var storage = const FlutterSecureStorage();
    String? mqttId = await storage.read(key: Settings.mqttId);
    String? password = await storage.read(key: Settings.password);

    try {
      await mClient.connect(mqttId, password);
    } on NoConnectionException {
      mClient.disconnect();
    } on SocketException {
      mClient.disconnect();
    }

    messages.forEach((topic, payload) {
      if (mClient.connectionStatus!.state == MqttConnectionState.connected) {
        mClient.publishMessage(topic, MqttQos.atLeastOnce, payload);
        results[topic] = true;
      }
    });

    mClient.disconnect();
    return results;
  }
}
