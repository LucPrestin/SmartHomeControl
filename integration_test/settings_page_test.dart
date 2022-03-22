import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:smart_home_control/main.dart' as app;
import 'package:smart_home_control/views/components/navigation_drawer.dart';

Future navigateToSettingsPage(WidgetTester tester) async {
  app.main();
  await tester.pumpAndSettle();

  await tester.tap(find
      .descendant(
        of: find.byType(AppBar),
        matching: find.byType(IconButton),
      )
      .first);
  await tester.pumpAndSettle();

  await tester.tap(find.byKey(const Key('to SettingsPage')));
  await tester.pumpAndSettle();
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    app.main();
  });

  testWidgets('opens navigation drawer on sandwich button tap',
      (WidgetTester tester) async {
    await tester.pumpAndSettle();

    await tester.tap(find
        .descendant(
          of: find.byType(AppBar),
          matching: find.byType(IconButton),
        )
        .first);
    await tester.pumpAndSettle();

    expect(find.byType(NavigationDrawer), findsOneWidget);
  });
}