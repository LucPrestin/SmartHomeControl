import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:smart_home_control/main.dart' as app;

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
