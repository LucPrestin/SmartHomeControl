import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:smart_home_control/views/pages/about_page.dart';
import 'package:smart_home_control/views/pages/light_list_page.dart';
import 'package:smart_home_control/views/pages/settings_page.dart';
import 'package:smart_home_control/views/pages/smart_hub_list_page.dart';

import 'utils.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('navigation drawer', () {
    testWidgets('navigates to settings page', (WidgetTester tester) async {
      await startApp(tester);
      await openNavigationDrawer(tester);

      await tester.tap(find.byKey(const Key('to SettingsPage')));
      await tester.pumpAndSettle();

      expect(find.byType(SettingsPage), findsOneWidget);
    });

    testWidgets('navigates to about page', (WidgetTester tester) async {
      await startApp(tester);
      await openNavigationDrawer(tester);

      await tester.tap(find.byKey(const Key('to AboutPage')));
      await tester.pumpAndSettle();

      expect(find.byType(AboutPage), findsOneWidget);
    });
  });

  group('bottom navigation', () {
    testWidgets('navigates to light list page', (WidgetTester tester) async {
      await startApp(tester);

      await tester.tap(find.text('Lights'));
      await tester.pumpAndSettle();

      expect(find.byType(LightListPage), findsOneWidget);
    });

    testWidgets('navigates to smart hub list page',
        (WidgetTester tester) async {
      await startApp(tester);

      await tester.tap(find.text('Smart Hubs'));
      await tester.pumpAndSettle();

      expect(find.byType(SmartHubListPage), findsOneWidget);
    });
  });
}
