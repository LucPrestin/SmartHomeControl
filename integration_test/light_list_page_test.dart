import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:smart_home_control/views/components/light_list_item.dart';

import 'package:smart_home_control/views/components/navigation_drawer.dart';
import 'package:smart_home_control/views/pages/light_add_page.dart';
import 'package:smart_home_control/views/pages/light_edit_page.dart';

import 'utils.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
      'opens navigation drawer when pressing the sandwich button in the app bar',
      (WidgetTester tester) async {
    await startApp(tester);

    await tester.tap(find
        .descendant(
          of: find.byType(AppBar),
          matching: find.byType(IconButton),
        )
        .first);
    await tester.pumpAndSettle();

    expect(find.byType(NavigationDrawer), findsOneWidget);
  });

  testWidgets(
      'navigates to a LightAddPage when pressing the floating action button',
      (WidgetTester tester) async {
    await startApp(tester);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.byType(LightAddPage), findsOneWidget);
  });

  group('light list item', () {
    const String stripName = 'name';

    setUpAll(() async {
      await addLightStripToDatabase(stripName);
    });

    tearDownAll(() async {
      await clearDatabase();
    });

    group('color rectangle', () {
      testWidgets('tap opens a SlidePicker', (WidgetTester tester) async {
        await startApp(tester);

        await tester.tap(find.byType(SizedBox).first);
        await tester.pumpAndSettle();

        expect(find.byType(SlidePicker), findsOneWidget);
      });

      testWidgets('color picker dialog closes on cancel',
          (WidgetTester tester) async {
        await startApp(tester);

        await tester.tap(find.byType(SizedBox).first);
        await tester.pumpAndSettle();

        await tester.tap(find.text('Cancel'));
        await tester.pumpAndSettle();

        expect(find.byType(SlidePicker), findsNothing);
      });

      testWidgets('color not changed on cancel', (WidgetTester tester) async {
        await startApp(tester);

        var finder1 = find.byType(DecoratedBox);
        var colorBoxes1 = tester.widgetList<DecoratedBox>(finder1);
        var color1 = (colorBoxes1.first.decoration as BoxDecoration).color;

        await tester.tap(find.byType(SizedBox).first);
        await tester.pumpAndSettle();

        await tester.drag(
            find.byType(ColorPickerSlider).first, const Offset(100, 0));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Cancel'));
        await tester.pumpAndSettle();

        var finder2 = find.byType(DecoratedBox);
        var colorBoxes2 = tester.widgetList<DecoratedBox>(finder2);
        var color2 = (colorBoxes2.first.decoration as BoxDecoration).color;

        expect(color2 == color1, true);
      });

      testWidgets('color changed on confirm', (WidgetTester tester) async {
        await startApp(tester);

        var finder1 = find.byType(DecoratedBox);
        var colorBoxes1 = tester.widgetList<DecoratedBox>(finder1);
        var color1 = (colorBoxes1.first.decoration as BoxDecoration).color;

        await tester.tap(find.byType(SizedBox).first);
        await tester.pumpAndSettle();

        await tester.drag(
            find.byType(ColorPickerSlider).first, const Offset(100, 0));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Confirm'));
        await tester.pumpAndSettle();

        var finder2 = find.byType(DecoratedBox);
        var colorBoxes2 = tester.widgetList<DecoratedBox>(finder2);
        var color2 = (colorBoxes2.first.decoration as BoxDecoration).color;

        expect(color1 == color2, false);
      });
    });

    group('edit button', () {
      testWidgets('tap opens light edit page', (WidgetTester tester) async {
        await startApp(tester);

        await tester.tap(find.widgetWithIcon(IconButton, Icons.edit));
        await tester.pumpAndSettle();

        expect(find.byType(LightEditPage), findsOneWidget);
      });
    });

    group('item deletion', () {
      testWidgets('swiping a light list item left opens a deletion dialog',
          (WidgetTester tester) async {
        await startApp(tester);

        await tester.drag(find.byType(LightListItem).first,
            Offset(tester.binding.window.physicalSize.width * -0.80, 0),
            warnIfMissed: false);
        await tester.pumpAndSettle();

        expect(
            find.descendant(
                of: find.byType(AlertDialog),
                matching: find.text('Delete $stripName?')),
            findsOneWidget);
      });

      testWidgets(
          'pressing cancel in confirmation dialog closes it and nothing changed',
          (WidgetTester tester) async {
        await startApp(tester);

        int countBefore =
            tester.widgetList<LightListItem>(find.byType(LightListItem)).length;

        await tester.drag(find.byType(LightListItem).first,
            Offset(tester.binding.window.physicalSize.width * -0.80, 0),
            warnIfMissed: false);
        await tester.pumpAndSettle();

        await tester.tap(find.text('Cancel'));
        await tester.pumpAndSettle();

        int countAfter =
            tester.widgetList<LightListItem>(find.byType(LightListItem)).length;

        expect(countAfter, countBefore);
      });

      testWidgets(
          'pressing confirm in confirmation dialog closes it and the list items is gone',
          (WidgetTester tester) async {
        await startApp(tester);

        int countBefore =
            tester.widgetList<LightListItem>(find.byType(LightListItem)).length;

        await tester.drag(find.byType(LightListItem).first,
            Offset(tester.binding.window.physicalSize.width * -0.80, 0),
            warnIfMissed: false);
        await tester.pumpAndSettle();

        await tester.tap(find.text('Confirm'));
        await tester.pumpAndSettle();

        int countAfter =
            tester.widgetList<LightListItem>(find.byType(LightListItem)).length;

        expect(countAfter, countBefore - 1);
      });
    });
  });
}
