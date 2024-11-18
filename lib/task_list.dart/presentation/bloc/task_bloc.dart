import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_to_do_app/locator.dart';
import 'package:simple_to_do_app/shared/utils/adapters/firebase_crashlytics_logger.dart';
import 'package:simple_to_do_app/shared/utils/adapters/notification_service/notification_service.dart';
import 'package:simple_to_do_app/task_list.dart/domain/entity/task.dart';
import 'package:simple_to_do_app/task_list.dart/domain/usecases/create_task_usecase.dart';
import 'package:simple_to_do_app/task_list.dart/domain/usecases/delete_task_usecase.dart';
import 'package:simple_to_do_app/task_list.dart/domain/usecases/get_tasks_usecase.dart';
import 'package:simple_to_do_app/task_list.dart/domain/usecases/update_task_usecase.dart';
import 'package:simple_to_do_app/shared/utils/adapters/uuid_adapter.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    on<TaskLoadedRequested>(_mapTaskLoadedRequested);
    on<TaskCreationRequested>(_mapTaskCreationRequested);
    on<TaskDeletionRequested>(_mapTaskDeletionRequested);
    on<TaskUpdateRequested>(_mapTaskUpdateRequested);
  }

  final createTaskUsecase = locator<CreateTaskUsecase>();
  final getTaskUsecase = locator<GetTasksUsecase>();
  final updateTaskUsecase = locator<UpdateTaskUsecase>();
  final deleteTaskUsecase = locator<DeleteTaskUsecase>();
  final uuId = locator<UuidAdapter>();

  Future<void> _mapTaskLoadedRequested(
    TaskLoadedRequested event,
    Emitter<TaskState> emit,
  ) async {
    emit(TaskLoadInProgress());
    try {
      final tasks = await getTaskUsecase();
      emit(TaskLoadSuccess(tasks: tasks));
    } catch (error, stackTrace) {
      locator<FirebaseCrashlyticsLogger>().error(error, stackTrace);
      emit(TaskLoadFailure());
    }
  }

  Future<void> _mapTaskCreationRequested(
    TaskCreationRequested event,
    Emitter<TaskState> emit,
  ) async {
    final id = uuId.createId();
    final task = Task(
      id: id,
      title: event.title,
      description: event.description,
      date: event.date,
    );
    final notificationId = id.hashCode;

    try {
      await createTaskUsecase(task);
      locator<NotificationService>().shceduleNotification(
        title: event.title,
        body: event.description,
        time: event.date,
        id: notificationId,
      );
      add(TaskLoadedRequested());
    } catch (error, stackTrace) {
      locator<FirebaseCrashlyticsLogger>().error(error, stackTrace);
      emit(TaskLoadFailure());
    }
  }

  Future<void> _mapTaskDeletionRequested(
    TaskDeletionRequested event,
    Emitter<TaskState> emit,
  ) async {
    try {
      await deleteTaskUsecase(event.id);
      final notificationId = event.id.hashCode;
      locator<NotificationService>().cancelNotification(id: notificationId);
      add(TaskLoadedRequested());
    } catch (error, stackTrace) {
      locator<FirebaseCrashlyticsLogger>().error(error, stackTrace);
      emit(TaskLoadFailure());
    }
  }

  Future<void> _mapTaskUpdateRequested(
    TaskUpdateRequested event,
    Emitter<TaskState> emit,
  ) async {
    final task = Task(
      id: event.id,
      title: event.title,
      description: event.description,
      date: event.date,
    );
    final notificationId = event.id.hashCode;
    try {
      await updateTaskUsecase(task);
      locator<NotificationService>().shceduleNotification(
        title: event.title,
        body: event.description,
        time: event.date,
        id: notificationId,
      );
      add(TaskLoadedRequested());
    } catch (error, stackTrace) {
      locator<FirebaseCrashlyticsLogger>().error(error, stackTrace);
      emit(TaskLoadFailure());
    }
  }
}
