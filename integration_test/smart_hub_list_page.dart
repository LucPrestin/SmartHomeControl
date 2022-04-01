import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:smart_home_control/views/components/navigation_drawer.dart';

import 'utils.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('opens navigation drawer on sandwich button tap',
      (WidgetTester tester) async {
    await startApp(tester);
    await navigateToSmartHubListPage(tester);

    Finder drawer = find
        .descendant(
          of: find.byType(AppBar),
          matching: find.byType(IconButton),
        )
        .first;
    await tester.tap(drawer);
    await tester.pumpAndSettle();

    expect(find.byType(NavigationDrawer), findsOneWidget);
  });
}
