import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_to_do_app/shared/utils/extensions/date_time.dart';
import 'package:simple_to_do_app/task_list.dart/presentation/widgets/task_list_card.dart';

import '../../../test_utils/app_wrapper.dart';

extension _WidgetTester on WidgetTester {
  Future<void> loadWidget({
    VoidCallback? onDelete,
    VoidCallback? onEdit,
  }) async {
    await pumpWidget(
      AppWrapper.wrap(
        child: TaskListCard(
          title: 'title',
          description: 'description',
          date: DateTime(2024),
          onDelete: onDelete ?? () {},
          onEdit: onEdit ?? () {},
        ),
      ),
    );
  }
}

void main() {
  testWidgets('Should render correctly', (tester) async {
    await tester.loadWidget();

    expect(find.byIcon(Icons.calendar_month), findsOneWidget);
    expect(find.text('TITLE'), findsOneWidget);
    expect(find.text('description'), findsOneWidget);
    expect(find.text(DateTime(2024).formatDateToLocale()), findsOneWidget);
    expect(find.byIcon(Icons.delete_outline), findsOneWidget);
    expect(find.byIcon(Icons.edit_outlined), findsOneWidget);
  });

  testWidgets('Should execute callbacks', (tester) async {
    int counter = 0;
    await tester.loadWidget(
      onDelete: () => counter++,
      onEdit: () => counter++,
    );

    await tester.tap(find.byIcon(Icons.delete_outline));
    expect(counter, 1);

    await tester.tap(find.byIcon(Icons.edit_outlined));
    expect(counter, 2);
  });
}
