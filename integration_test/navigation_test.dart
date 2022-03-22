import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:smart_home_control/main.dart' as app;
import 'package:smart_home_control/views/pages/about_page.dart';
import 'package:smart_home_control/views/pages/light_list_page.dart';
import 'package:smart_home_control/views/pages/settings_page.dart';
import 'package:smart_home_control/views/pages/smart_hub_list_page.dart';

Future openNavigationDrawer(WidgetTester tester) async {
  await tester.pumpAndSettle();

  await tester.tap(find
      .descendant(
        of: find.byType(AppBar),
        matching: find.byType(IconButton),
      )
      .first);
  await tester.pumpAndSettle();
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    app.main();
  });

  testWidgets('navigates to light list page', (WidgetTester tester) async {
    await openNavigationDrawer(tester);

    await tester.tap(find.byKey(const Key('to LightListPage')));
    await tester.pumpAndSettle();

    expect(find.byType(LightListPage), findsOneWidget);
  });

  testWidgets('navigates to smart hub list page', (WidgetTester tester) async {
    await openNavigationDrawer(tester);

    await tester.tap(find.byKey(const Key('to SmartHubListPage')));
    await tester.pumpAndSettle();

    expect(find.byType(SmartHubListPage), findsOneWidget);
  });

  testWidgets('navigates to settings page', (WidgetTester tester) async {
    await openNavigationDrawer(tester);

    await tester.tap(find.byKey(const Key('to SettingsPage')));
    await tester.pumpAndSettle();

    expect(find.byType(SettingsPage), findsOneWidget);
  });

  testWidgets('navigates to about page', (WidgetTester tester) async {
    await openNavigationDrawer(tester);

    await tester.tap(find.byKey(const Key('to AboutPage')));
    await tester.pumpAndSettle();

    expect(find.byType(AboutPage), findsOneWidget);
  });
}
