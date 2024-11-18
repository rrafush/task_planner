import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_to_do_app/shared/utils/adapters/firebase_crashlytics_logger.dart';
import 'package:simple_to_do_app/shared/utils/adapters/notification_service/notification_service.dart';
import 'package:simple_to_do_app/shared/utils/adapters/uuid_adapter.dart';
import 'package:simple_to_do_app/task_list.dart/domain/entity/task.dart';
import 'package:simple_to_do_app/task_list.dart/domain/usecases/create_task_usecase.dart';
import 'package:simple_to_do_app/task_list.dart/domain/usecases/delete_task_usecase.dart';
import 'package:simple_to_do_app/task_list.dart/domain/usecases/get_tasks_usecase.dart';
import 'package:simple_to_do_app/task_list.dart/domain/usecases/update_task_usecase.dart';
import 'package:simple_to_do_app/task_list.dart/presentation/bloc/task_bloc.dart';

import '../../../locator_mock.dart';

void main() {
  late final CreateTaskUsecase createTaskUsecase;
  late final GetTasksUsecase getTaskUsecase;
  late final UpdateTaskUsecase updateTaskUsecase;
  late final DeleteTaskUsecase deleteTaskUsecase;

  final task = Task(
    id: '123',
    title: 'title',
    description: 'description',
    date: DateTime(2024),
  );

  setUpAll(() {
    setupLocatorMock();
    createTaskUsecase = locator<CreateTaskUsecase>();
    getTaskUsecase = locator<GetTasksUsecase>();
    updateTaskUsecase = locator<UpdateTaskUsecase>();
    deleteTaskUsecase = locator<DeleteTaskUsecase>();

    registerFallbackValue(StackTrace.empty);
    registerFallbackValue(
      Task(
        id: '',
        title: '',
        description: '',
        date: DateTime(2024),
      ),
    );

    when(
      () => locator<FirebaseCrashlyticsLogger>().error(
        any(),
        any(),
        reason: any(named: 'reason'),
      ),
    ).thenReturn(null);
  });

  setUp(() {
    when(() => getTaskUsecase.call()).thenAnswer((_) => Future.value([]));
  });

  group('mapTaskLoadedRequested', () {
    blocTest(
      'Should emit TaskLoadInProgress and TaskLoadSuccess when fetch tasks is successful',
      build: () => TaskBloc(),
      act: (bloc) => bloc.add(TaskLoadedRequested()),
      expect: () => [
        TaskLoadInProgress(),
        TaskLoadSuccess(),
      ],
      verify: (_) {
        verify(() => getTaskUsecase.call()).called(1);
      },
    );

    blocTest(
        'Should emit TaskLoadInProgress and TaskLoadFailure when fetch tasks is not successful'
        'and log error in crashlytics',
        build: () => TaskBloc(),
        setUp: () {
          when(() => getTaskUsecase.call()).thenThrow(Exception());
        },
        act: (bloc) => bloc.add(TaskLoadedRequested()),
        expect: () => [
              TaskLoadInProgress(),
              TaskLoadFailure(),
            ],
        verify: (_) {
          verify(
            () => locator<FirebaseCrashlyticsLogger>().error(
              any(),
              any(),
              reason: any(named: 'reason'),
            ),
          ).called(1);
        });
  });

  group('mapTaskCreationRequested', () {
    blocTest(
      'Should add TaskLoadedRequested event when creating task is successful',
      build: () => TaskBloc(),
      setUp: () {
        when(() => createTaskUsecase.call(any()))
            .thenAnswer((_) => Future.value());
        when(() => locator<UuidAdapter>().createId()).thenReturn(task.id);
        when(
          () => locator<NotificationService>().shceduleNotification(
            title: any(named: 'title'),
            body: any(named: 'body'),
            time: any(named: 'time'),
            id: any(named: 'id'),
          ),
        ).thenAnswer(
          (_) => Future.value(),
        );
      },
      act: (bloc) => bloc.add(
        TaskCreationRequested(
          title: task.title,
          description: task.description,
          date: task.date,
        ),
      ),
      expect: () => [
        TaskLoadInProgress(),
        TaskLoadSuccess(tasks: []),
      ],
      verify: (_) {
        verify(
          () => locator<NotificationService>().shceduleNotification(
            title: task.title,
            body: task.description,
            time: task.date,
            id: task.id.hashCode,
          ),
        ).called(1);
        verify(
          () => createTaskUsecase.call(task),
        ).called(1);
      },
    );

    blocTest(
        'Should emit TaskLoadFailure when creating task is not successful'
        'and log error in crashlytics',
        build: () => TaskBloc(),
        setUp: () {
          when(() => locator<UuidAdapter>().createId()).thenReturn(task.id);
          when(
            () => locator<NotificationService>().shceduleNotification(
              title: any(named: 'title'),
              body: any(named: 'body'),
              time: any(named: 'time'),
              id: any(named: 'id'),
            ),
          ).thenAnswer((_) => Future.value());
          when(() => createTaskUsecase.call(any())).thenThrow(Exception());
        },
        act: (bloc) => bloc.add(
              TaskCreationRequested(
                title: task.title,
                description: task.description,
                date: task.date,
              ),
            ),
        expect: () => [
              TaskLoadFailure(),
            ],
        verify: (_) {
          verify(
            () => locator<FirebaseCrashlyticsLogger>().error(
              any(),
              any(),
              reason: any(named: 'reason'),
            ),
          ).called(1);
        });
  });

  group('mapTaskDeletionRequested', () {
    blocTest(
      'Should add TaskLoadedRequested event when deleting task is successful',
      build: () => TaskBloc(),
      setUp: () {
        when(() => deleteTaskUsecase.call(any()))
            .thenAnswer((_) => Future.value());
        when(
          () => locator<NotificationService>().cancelNotification(
            id: any(named: 'id'),
          ),
        ).thenAnswer(
          (_) => Future.value(),
        );
      },
      act: (bloc) => bloc.add(
        TaskDeletionRequested(task.id),
      ),
      expect: () => [
        TaskLoadInProgress(),
        TaskLoadSuccess(tasks: []),
      ],
      verify: (bloc) {
        verify(
          () => locator<NotificationService>().cancelNotification(
            id: task.id.hashCode,
          ),
        ).called(1);
        verify(
          () => deleteTaskUsecase.call(task.id),
        ).called(1);
      },
    );

    blocTest(
        'Should emit TaskLoadFailure when deleting task is not successful'
        'and log error in crashlytics',
        build: () => TaskBloc(),
        setUp: () {
          when(
            () => locator<NotificationService>().cancelNotification(
              id: any(named: 'id'),
            ),
          ).thenAnswer((_) => Future.value());
          when(() => deleteTaskUsecase.call(any())).thenThrow(Exception());
        },
        act: (bloc) => bloc.add(
              TaskDeletionRequested(task.id),
            ),
        expect: () => [
              TaskLoadFailure(),
            ],
        verify: (_) {
          verify(
            () => locator<FirebaseCrashlyticsLogger>().error(
              any(),
              any(),
              reason: any(named: 'reason'),
            ),
          ).called(1);
        });
  });

  group('mapTaskUpdateRequested', () {
    blocTest(
      'Should add TaskLoadedRequested event when updating task is successful',
      build: () => TaskBloc(),
      setUp: () {
        when(() => updateTaskUsecase.call(any()))
            .thenAnswer((_) => Future.value());
        when(
          () => locator<NotificationService>().shceduleNotification(
            title: any(named: 'title'),
            body: any(named: 'body'),
            time: any(named: 'time'),
            id: any(named: 'id'),
          ),
        ).thenAnswer(
          (_) => Future.value(),
        );
      },
      act: (bloc) => bloc.add(
        TaskUpdateRequested(
          id: task.id,
          title: task.title,
          description: task.description,
          date: task.date,
        ),
      ),
      expect: () => [
        TaskLoadInProgress(),
        TaskLoadSuccess(tasks: []),
      ],
      verify: (bloc) {
        verify(
          () => locator<NotificationService>().shceduleNotification(
            title: task.title,
            body: task.description,
            time: task.date,
            id: task.id.hashCode,
          ),
        ).called(1);
        verify(
          () => updateTaskUsecase.call(task),
        ).called(1);
      },
    );

    blocTest(
        'Should emit TaskLoadFailure when updating task is not successful'
        'and log error in crashlytics',
        build: () => TaskBloc(),
        setUp: () {
          when(
            () => locator<NotificationService>().shceduleNotification(
              title: any(named: 'title'),
              body: any(named: 'body'),
              time: any(named: 'time'),
              id: any(named: 'id'),
            ),
          ).thenAnswer(
            (_) => Future.value(),
          );
          when(() => updateTaskUsecase.call(any())).thenThrow(Exception());
        },
        act: (bloc) => bloc.add(
              TaskUpdateRequested(
                id: task.id,
                title: task.title,
                description: task.description,
                date: task.date,
              ),
            ),
        expect: () => [
              TaskLoadFailure(),
            ],
        verify: (_) {
          verify(
            () => locator<FirebaseCrashlyticsLogger>().error(
              any(),
              any(),
              reason: any(named: 'reason'),
            ),
          ).called(1);
        });
  });
}
