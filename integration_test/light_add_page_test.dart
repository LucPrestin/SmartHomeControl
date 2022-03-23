import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:integration_test/integration_test.dart';

import 'package:smart_home_control/views/components/light_list_item.dart';
import 'package:smart_home_control/views/pages/light_list_page.dart';

import 'utils.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
      'Returns to the light list page when pressing the back button in the app bar',
      (WidgetTester tester) async {
    await startApp(tester);
    await navigateToLightAddPage(tester);

    await tester.tap(find
        .descendant(
          of: find.byType(AppBar),
          matching: find.byType(IconButton),
        )
        .first);
    await tester.pumpAndSettle();

    expect(find.byType(LightListPage), findsOneWidget);
  });

  testWidgets('returns to light list page after successful addition',
      (WidgetTester tester) async {
    await startApp(tester);
    await navigateToLightAddPage(tester);

    await tester.enterText(find.byKey(const Key('field name')), 'Name');
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('field mqttId')), 'mqttId');
    await tester.pumpAndSettle();

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.byType(LightListPage), findsOneWidget);
  });

  testWidgets('light list page has one more entry after successful addition',
      (WidgetTester tester) async {
    await startApp(tester);

    int countBefore =
        tester.widgetList<LightListItem>(find.byType(LightListItem)).length;

    await navigateToLightAddPage(tester);

    await tester.enterText(find.byKey(const Key('field name')), 'Name');
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('field mqttId')), 'mqttId');
    await tester.pumpAndSettle();

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    int countAfter =
        tester.widgetList<LightListItem>(find.byType(LightListItem)).length;

    expect(countAfter, countBefore + 1);
  });

  testWidgets('shows error message when name field is empty',
      (WidgetTester tester) async {
    await startApp(tester);
    await navigateToLightAddPage(tester);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.text('Please enter a name'), findsOneWidget);
  });

  testWidgets('shows error message when mqttId field is empty',
      (WidgetTester tester) async {
    await startApp(tester);
    await navigateToLightAddPage(tester);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.text('Please enter an ID'), findsOneWidget);
  });
}
