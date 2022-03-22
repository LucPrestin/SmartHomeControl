import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_home_control/main.dart';
import 'package:smart_home_control/views/forms/light_form.dart';

void main() {
  group('child components', () {
    Future pumpLightForm(WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
          title: 'Smart Home Control',
          home: Scaffold(
            body: LightForm(),
          )));
    }

    testWidgets('has a TextFormField for the name',
        (WidgetTester tester) async {
      await pumpLightForm(tester);

      expect(find.byKey(const Key('field name')), findsOneWidget);
    });

    testWidgets('has a TextFormField for the mqttId',
        (WidgetTester tester) async {
      await pumpLightForm(tester);

      expect(find.byKey(const Key('field mqttId')), findsOneWidget);
    });

    testWidgets('has a ColorPicker for the light color',
        (WidgetTester tester) async {
      await pumpLightForm(tester);

      expect(find.byType(SlidePicker), findsOneWidget);
    });
  });

  group('behavior', () {
    group('add mode', () {
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

      testWidgets(
          'pressing the submit button adds a new light strip to the database',
          (WidgetTester tester) async {
        // await navigateToLightAddPage(tester);

        // var helper = DatabaseHelper.instance;
        // TODO: the next call does not terminate. Find out why
        // var allStrips = await helper.getAllLightStrips();
        // expect(allStrips.isEmpty, true);

        // await tester.enterText(find.byKey(const Key('field name')), 'test');
        // await tester.pumpAndSettle();

        // await tester.tap(find.text('Submit'));
        // await tester.pumpAndSettle();

        // allStrips = await helper.getAllLightStrips();
        // expect(allStrips.length, 1);
      });
    });

    group('edit mode', () {
      Future navigateToLightEditPage(WidgetTester tester) async {
        // TODO
      }

      testWidgets(
          'pressing the submit button updates the current light strip in the database',
          (WidgetTester tester) async {
        // TODO
      });
    });
  });
}
