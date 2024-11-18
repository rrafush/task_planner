import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_to_do_app/task_list.dart/presentation/bloc/task_bloc.dart';
import 'package:simple_to_do_app/task_list.dart/presentation/widgets/create_or_edit_task_bottom_sheet.dart';

import '../../../locator_mock.dart';
import '../../../test_utils/app_wrapper.dart';
import '../bloc/task_bloc_mock.dart' as task_bloc_mock;

extension _WidgetTester on WidgetTester {
  Future<void> loadWidget({
    String? title,
    String? description,
    DateTime? date,
    TaskBloc? bloc,
  }) async {
    final GlobalKey<AnimatedListState> animatedListKey = GlobalKey();
    await pumpWidget(
      AppWrapper.wrap(
        taskBloc: bloc,
        child: Scaffold(
          body: CreateOrEditTaskBottomSheet(
            title: title,
            description: description,
            date: date,
            animatedListKey: animatedListKey,
            index: 0,
          ),
        ),
      ),
    );
  }
}

void main() {
  setUpAll(() {
    setupLocatorMock();
    AppWrapper.registerFallbackValues();
  });

  testWidgets('Should render correctly', (tester) async {
    await tester.loadWidget();

    expect(find.byKey(const Key('TitleFormField')), findsOneWidget);
    expect(find.text('Title'), findsOneWidget);

    expect(find.byKey(const Key('DescriptionFormField')), findsOneWidget);
    expect(find.text('Description'), findsOneWidget);

    expect(find.byKey(const Key('DateFormField')), findsOneWidget);
    expect(find.byIcon(Icons.calendar_month), findsOneWidget);
  });

  testWidgets(
      'Should display error messages and not save when task is not valid',
      (tester) async {
    final taskBloc = task_bloc_mock.defineBloc();
    await tester.loadWidget(
      bloc: taskBloc,
    );

    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Please, enter a title'), findsOneWidget);
    expect(find.text('Choose a date that is not in the past'), findsOneWidget);

    verifyNever(
      () => taskBloc.add(any()),
    );
  });

  testWidgets('Should save task when it is valid', (tester) async {
    final taskBloc = task_bloc_mock.defineBloc();
    await tester.loadWidget(
      bloc: taskBloc,
    );

    await tester.enterText(find.byKey(const Key('TitleFormField')), 'title');
    await tester.enterText(
        find.byKey(const Key('DescriptionFormField')), 'description');
    await tester.tap(find.byKey(const Key('DateFormField')));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.chevron_right));
    await tester.pumpAndSettle();
    await tester.tap(find.text('20'));

    await tester.ensureVisible(find.text('OK'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));

    await tester.ensureVisible(find.text('OK'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));

    await tester.pumpAndSettle();

    expect(find.text('Please, enter a title'), findsNothing);
    expect(find.text('Choose a date that is not in the past'), findsNothing);

    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    final capturedArguments = verify(
      () => taskBloc.add(captureAny()),
    ).captured;

    expect(capturedArguments.length, 1);

    expect(capturedArguments[0], isA<TaskCreationRequested>());
    expect(
      (capturedArguments[0] as TaskCreationRequested).title,
      'title',
    );
    expect(
      (capturedArguments[0] as TaskCreationRequested).description,
      'description',
    );
  });
}
