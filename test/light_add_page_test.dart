import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_home_control/main.dart';
import 'package:smart_home_control/views/forms/light_form.dart';

void main() {
  Future navigateToLightAddPage(WidgetTester tester) async {
    await tester.pumpWidget(const SmartHomeControlApp());
    await tester.pumpAndSettle();

    await tester.dragFrom(
        tester.getTopLeft(find.byType(MaterialApp)), const Offset(300, 0));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.lightbulb));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
  }

  group('child components', () {
    testWidgets('has a LightForm', (WidgetTester tester) async {
      await navigateToLightAddPage(tester);

      expect(find.byType(LightForm), findsOneWidget);
    });

    testWidgets('has a FloatingActionButton to submit',
        (WidgetTester tester) async {
      await navigateToLightAddPage(tester);

      expect(find.byType(FloatingActionButton), findsOneWidget);
    });
  });
}
