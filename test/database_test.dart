import 'package:flutter_test/flutter_test.dart';
import 'package:smart_home_control/models/database.dart';
import 'package:smart_home_control/models/light_strip.dart';

import 'factories.dart';

void main() {
  group("DatabaseHelper", () async {
    test('Has no light strips at the beginning', () async {
      List<LightStrip> allStrips =
          await DatabaseHelper.instance.getAllLightStrips();
      expect(allStrips.isEmpty, true);
    });

    test('Can insert light strips', () async {
      var helper = DatabaseHelper.instance;

      expect((await helper.getAllLightStrips()).isEmpty, true);

      helper.insertLightStrip(LightStripFactory.createLightStrip());
      expect((await helper.getAllLightStrips()).length, 1);
    });

    test('Can retrieve light strips', () async {});

    test('Can update light strips', () async {});

    test('Can delete light strips', () async {});
  });
}
