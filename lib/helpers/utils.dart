import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

Future<String?> getDeviceName() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  String? name;

  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    name = androidInfo.display;
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    name = iosInfo.name;
  } else {
    // currently not supported
  }

  return name;
}
