import 'package:smart_home_control/models/light_strip.dart';

class LightStripFactory {
  static int lastUsedId = 0;

  static LightStrip createLightStrip({id, name}) {
    if (!id) {
      id = lastUsedId;
      lastUsedId++;
    }

    if (!name) {
      name = "test";
    }

    return LightStrip(id: id, name: name);
  }
}
