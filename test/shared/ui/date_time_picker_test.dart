import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_to_do_app/shared/ui/date_time_picker.dart';

void main() {
  Future<void> loadWidget(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          key: const Key('app'),
          body: ElevatedButton(
            onPressed: () async {
              final context = tester.firstElement(find.byKey(const Key('app')))
                  as BuildContext;
              await showDateTimePicker(
                context: context,
              );
            },
            child: Text('Open Date Time Picker'),
          ),
        ),
      ),
    );
  }

  testWidgets('Should open date time picker', (tester) async {
    await loadWidget(tester);
    await tester.tap(find.text('Open Date Time Picker'));
    await tester.pumpAndSettle();

    //Date Picker
    expect(find.text('Cancel'), findsOneWidget);
    expect(find.text('OK'), findsOneWidget);

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    //Time Picker
    expect(find.text('Cancel'), findsOneWidget);
    expect(find.text('OK'), findsOneWidget);

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    expect(find.text('Cancel'), findsNothing);
    expect(find.text('OK'), findsNothing);
  });
}
