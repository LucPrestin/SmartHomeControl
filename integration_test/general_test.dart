import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:smart_home_control/views/pages/light_list_page.dart';

import 'utils.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('starts to the light list page', (WidgetTester tester) async {
    await startApp(tester);

    expect(find.byType(LightListPage), findsOneWidget);
  });
}
