import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_home_control/main.dart';
import 'package:smart_home_control/views/pages/light_add_page.dart';

void main() {
  Future navigateToLightListPage(WidgetTester tester) async {
    await tester.pumpWidget(const SmartHomeControlApp());
    await tester.pumpAndSettle();

    await tester.dragFrom(
        tester.getTopLeft(find.byType(MaterialApp)), const Offset(300, 0));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.lightbulb));
    await tester.pumpAndSettle();
  }

  group('child components', () {
    testWidgets('has a FloatingActionButton', (WidgetTester tester) async {
      await navigateToLightListPage(tester);

      expect(find.byType(FloatingActionButton), findsOneWidget);
    });
  });
  group('routing', () {
    testWidgets('clicking the fab routes to the LightAddPage',
        (WidgetTester tester) async {
      await navigateToLightListPage(tester);

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(find.byType(LightAddPage), findsOneWidget);
    });
  });
}
