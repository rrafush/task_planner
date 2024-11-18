part of 'task_bloc.dart';

class TaskState extends Equatable {
  const TaskState({
    this.tasks = const [],
  });

  final List<Task> tasks;

  @override
  List<Object> get props => [
        tasks,
      ];
}

final class TaskInitial extends TaskState {}

final class TaskLoadInProgress extends TaskState {}

final class TaskLoadSuccess extends TaskState {
  const TaskLoadSuccess({
    super.tasks,
  });
}

final class TaskLoadFailure extends TaskState {
  const TaskLoadFailure();
}
