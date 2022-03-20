import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_home_control/main.dart';
import 'package:smart_home_control/views/components/navigation_drawer.dart';
import 'package:smart_home_control/views/pages/about_page.dart';
import 'package:smart_home_control/views/pages/light_list_page.dart';
import 'package:smart_home_control/views/pages/smart_hub_list_page.dart';

void main() {
  group('child widgets', () {
    testWidgets('has a button for the LightListPage',
        (WidgetTester tester) async {
      await tester.pumpWidget(const NavigationDrawer());
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('to LightListPage')), findsOneWidget);
    });
    testWidgets('has a button for the SmartHubPage',
        (WidgetTester tester) async {
      await tester.pumpWidget(const NavigationDrawer());
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('to SmartHubListPage')), findsOneWidget);
    });

    testWidgets('has a button for the SettingsPage',
        (WidgetTester tester) async {
      await tester.pumpWidget(const NavigationDrawer());
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('to SettingsPage')), findsOneWidget);
    });

    testWidgets('has a button for the AboutPage', (WidgetTester tester) async {
      await tester.pumpWidget(const NavigationDrawer());
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('to AboutPage')), findsOneWidget);
    });
  });
}
