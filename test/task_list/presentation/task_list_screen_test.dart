import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_to_do_app/task_list.dart/domain/entity/task.dart';
import 'package:simple_to_do_app/task_list.dart/presentation/bloc/task_bloc.dart';
import 'package:simple_to_do_app/task_list.dart/presentation/task_list_screen.dart';
import 'package:simple_to_do_app/task_list.dart/presentation/widgets/create_or_edit_task_bottom_sheet.dart';
import 'package:simple_to_do_app/task_list.dart/presentation/widgets/task_list_card.dart';

import 'bloc/task_bloc_mock.dart'
    as task_bloc_mock;
import '../../test_utils/app_wrapper.dart';

extension _WidgetTester on WidgetTester {
  Future<void> loadWidget({
    TaskBloc? taskBloc,
  }) async {
    await pumpWidget(
      AppWrapper.wrap(
        taskBloc: taskBloc,
        child: TaskListScreen(),
      ),
    );
  }
}

void main() {
  setUpAll(() {
    AppWrapper.registerFallbackValues();
  });
  testWidgets('Should render correctly in empty state', (tester) async {
    final taskBloc =
        task_bloc_mock.defineBloc(newState: TaskLoadSuccess(tasks: []));
    await tester.loadWidget(
      taskBloc: taskBloc,
    );

    expect(find.byKey(const Key('EmptyState')), findsOneWidget);
    expect(find.text('You have no tasks yet! Create one!'), findsOneWidget);
    expect(find.byType(TaskListCard), findsNothing);
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });

  testWidgets('Should render correctly in error state', (tester) async {
    final taskBloc = task_bloc_mock.defineBloc(newState: TaskLoadFailure());
    await tester.loadWidget(
      taskBloc: taskBloc,
    );

    expect(find.byKey(const Key('EmptyState')), findsNothing);
    expect(find.text('You have no tasks yet! Create one!'), findsNothing);
    expect(find.byType(TaskListCard), findsNothing);
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.byKey(const Key('ErrorState')), findsOneWidget);
  });

  testWidgets('Should render correctly in loading state', (tester) async {
    final taskBloc = task_bloc_mock.defineBloc(newState: TaskLoadInProgress());
    await tester.loadWidget(
      taskBloc: taskBloc,
    );

    expect(find.byKey(const Key('EmptyState')), findsNothing);
    expect(find.byKey(const Key('ErrorState')), findsNothing);
    expect(find.byType(TaskListCard), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should render correctly in success state', (tester) async {
    final taskBloc = task_bloc_mock.defineBloc(
      newState: TaskLoadSuccess(
        tasks: List.generate(
          3,
          (index) => Task(
            id: index.toString(),
            title: 'Task $index',
            description: 'Description $index',
            date: DateTime(2024),
          ),
        ),
      ),
    );
    await tester.loadWidget(
      taskBloc: taskBloc,
    );

    expect(find.byKey(const Key('EmptyState')), findsNothing);
    expect(find.byKey(const Key('ErrorState')), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsNothing);

    expect(find.byType(TaskListCard), findsNWidgets(3));
  });

  testWidgets('Should open bottom sheet on tap floating action button',
      (tester) async {
    final taskBloc =
        task_bloc_mock.defineBloc(newState: TaskLoadSuccess(tasks: []));
    await tester.loadWidget(
      taskBloc: taskBloc,
    );

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();

    expect(find.byType(CreateOrEditTaskBottomSheet), findsOneWidget);
  });
}
