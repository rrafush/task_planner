import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_to_do_app/shared/ui/bottom_sheet.dart';

void main() {
  Future<void> loadWidget(
    WidgetTester tester, {
    VoidCallback? onClosing,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          key: const Key('app'),
          body: ElevatedButton(
            onPressed: () {
              final context = tester.firstElement(find.byKey(const Key('app')))
                  as BuildContext;
              displayModalBottomSheet(
                context: context,
                child: Container(
                  key: const Key('bottomSheet'),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Close Bottom Sheet',
                    ),
                  ),
                ),
                onClosing: onClosing,
              );
            },
            child: Text('Open Bottom Sheet'),
          ),
        ),
      ),
    );
  }

  testWidgets('Should render bottom sheet correctly', (tester) async {
    await loadWidget(tester);

    expect(find.byKey(const Key('bottomSheet')), findsNothing);
    await tester.tap(find.text('Open Bottom Sheet'));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('bottomSheet')), findsOneWidget);
  });

  testWidgets('Should execute onClosing function when bottom sheet is closed',
      (tester) async {
    var counter = 0;
    await loadWidget(tester, onClosing: () => counter++);
    await tester.tap(find.text('Open Bottom Sheet'));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('bottomSheet')), findsOneWidget);
    await tester.tap(find.text('Close Bottom Sheet'));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('bottomSheet')), findsNothing);
    expect(counter, 1);
  });
}
