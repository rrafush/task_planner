import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:simple_to_do_app/main.dart' as app;
import 'package:simple_to_do_app/task_list.dart/presentation/widgets/task_list_card.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  testWidgets(
    "Should create task",
    (WidgetTester tester) async {
      app.main();
      await tester.pump(const Duration(seconds: 5));

      expect(find.byType(TaskListCard), findsNothing);

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump(const Duration(seconds: 5));

      await tester.enterText(
          find.byKey(const Key('TitleFormField')), 'Anna\'s Birthday');
      await tester.pump(const Duration(seconds: 2));
      await tester.enterText(find.byKey(const Key('DescriptionFormField')),
          'Costume party at her house, buy gift');
      await tester.pump(const Duration(seconds: 2));
      await tester.tap(find.byKey(const Key('DateFormField')));
      await tester.pump(const Duration(seconds: 5));
      await tester.tap(find.byIcon(Icons.chevron_right));
      await tester.pump(const Duration(seconds: 5));
      await tester.tap(find.text('20'));
      await tester.pump(const Duration(seconds: 5));
      await tester.tap(find.text('OK'));
      await tester.pump(const Duration(seconds: 5));
      await tester.tap(find.text('OK'));
      await tester.pump(const Duration(seconds: 5));

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump(const Duration(seconds: 5));

      expect(find.text('Anna\'s Birthday'.toUpperCase()), findsOneWidget);
      expect(find.text('Costume party at her house, buy gift'), findsOneWidget);
      expect(find.byType(TaskListCard), findsOneWidget);
    },
    timeout: Timeout(
      const Duration(minutes: 5),
    ),
  );
}
