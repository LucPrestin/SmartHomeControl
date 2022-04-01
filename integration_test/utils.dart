import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_home_control/helpers/database.dart';

import 'package:smart_home_control/main.dart' as app;
import 'package:smart_home_control/models/light_strip.dart';

Future startApp(WidgetTester tester) async {
  app.main();
  await tester.pumpAndSettle();
}

Future navigateToAboutPage(WidgetTester tester) async {
  await tester.tap(find
      .descendant(
        of: find.byType(AppBar),
        matching: find.byType(IconButton),
      )
      .first);
  await tester.pumpAndSettle();

  await tester.tap(find.byKey(const Key('to AboutPage')));
  await tester.pumpAndSettle();
}

Future navigateToLightAddPage(WidgetTester tester) async {
  await tester.tap(find.byType(FloatingActionButton));
  await tester.pumpAndSettle();
}

Future openNavigationDrawer(WidgetTester tester) async {
  await tester.tap(find
      .descendant(
        of: find.byType(AppBar),
        matching: find.byType(IconButton),
      )
      .first);
  await tester.pumpAndSettle();
}

Future navigateToSettingsPage(WidgetTester tester) async {
  await tester.tap(find
      .descendant(
        of: find.byType(AppBar),
        matching: find.byType(IconButton),
      )
      .first);
  await tester.pumpAndSettle();

  await tester.tap(find.byKey(const Key('to SettingsPage')));
  await tester.pumpAndSettle();
}

Future navigateToSmartHubListPage(WidgetTester tester) async {
  await tester.tap(find
      .descendant(
        of: find.byType(AppBar),
        matching: find.byType(IconButton),
      )
      .first);
  await tester.pumpAndSettle();

  await tester.tap(find.byKey(const Key('to SmartHubListPage')));
  await tester.pumpAndSettle();
}

Future addLightStripToDatabase(String name) async {
  var database = DatabaseHelper.instance;
  await database.insertLightStrip(LightStrip(name: name));
}

Future clearDatabase() async {
  var database = DatabaseHelper.instance;
  var strips = await database.getAllLightStrips();
  var futures = <Future>[];
  for (var strip in strips) {
    futures.add(database.removeLightStrip(strip));
  }
  await Future.wait(futures);
}
