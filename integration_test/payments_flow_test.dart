import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:base_project/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('loads payments and switches tabs', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Waits for shimmer or loading to disappear
    await tester.pump(const Duration(seconds: 6));

    // Verifies that the initial tab is visible
    expect(find.textContaining(r'$'), findsWidgets);

    // Taps on the "Transactions" tab
    final tabFinder = find.text('TRANSACTIONS');
    expect(tabFinder, findsOneWidget);
    await tester.tap(tabFinder);
    await tester.pumpAndSettle();

    // Verifies that something related to transactions is rendered
    expect(find.textContaining('Amount'), findsWidgets);
  });
}
