import 'package:flutter/material.dart';
import 'package:flutter_skeleton/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Integrations tests', () {
    testWidgets('Integrations test', (WidgetTester tester) async {
      // Init app
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.text('2 Students'));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 3));

      expect(find.byIcon(Icons.favorite_border), findsWidgets);
      expect(find.byIcon(Icons.favorite), findsNothing);

      await tester.tap(find.byIcon(Icons.favorite_border).first);
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsOneWidget);
    });
  });
}
