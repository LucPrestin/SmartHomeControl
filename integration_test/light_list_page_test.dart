import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

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
    group('edit button', () {
      testWidgets('tap opens light edit page', (WidgetTester tester) async {
        await startApp(tester);
        await addLightStripToDatabase(tester);

        await tester.tap(find.widgetWithIcon(IconButton, Icons.edit));
        await tester.pumpAndSettle();

        expect(find.byType(LightEditPage), findsOneWidget);
      });
    });
  });
}
