import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_home_control/main.dart';
import 'package:smart_home_control/views/about_page.dart';
import 'package:smart_home_control/views/light_form.dart';
import 'package:smart_home_control/views/light_list_page.dart';
import 'package:smart_home_control/views/smart_hub_list_page.dart';

void main() {
  Future openDrawer(WidgetTester tester) async {
    await tester.pumpWidget(const SmartHomeControlApp());
    await tester.pumpAndSettle();

    await tester.dragFrom(
        tester.getTopLeft(find.byType(MaterialApp)), const Offset(300, 0));
    await tester.pumpAndSettle();
  }

  group('child widgets', () {
    testWidgets('has a button for the LightListPage',
        (WidgetTester tester) async {
      await openDrawer(tester);

      expect(find.byKey(const Key('to LightListPage')), findsOneWidget);
    });
    testWidgets('has a button for the SmartHubPage',
        (WidgetTester tester) async {
      await openDrawer(tester);

      expect(find.byKey(const Key('to SmartHubListPage')), findsOneWidget);
    });
    testWidgets('has a button for the AboutPage', (WidgetTester tester) async {
      await openDrawer(tester);

      expect(find.byKey(const Key('to AboutPage')), findsOneWidget);
    });
  });

  group('navigation', () {
    testWidgets('navigates to the LightListPage', (WidgetTester tester) async {
      await openDrawer(tester);

      await tester.tap(find.byIcon(Icons.lightbulb));
      await tester.pumpAndSettle();

      expect(find.byType(LightListPage), findsOneWidget);
    });

    testWidgets('navigates to the SmartHubListPage',
        (WidgetTester tester) async {
      await openDrawer(tester);

      await tester.tap(find.byIcon(Icons.device_hub));
      await tester.pumpAndSettle();

      expect(find.byType(SmartHubListPage), findsOneWidget);
    });

    testWidgets('navigates to the AboutPage', (WidgetTester tester) async {
      await openDrawer(tester);

      await tester.tap(find.byIcon(Icons.info));
      await tester.pumpAndSettle();

      expect(find.byType(AboutPage), findsOneWidget);
    });
  });
}
