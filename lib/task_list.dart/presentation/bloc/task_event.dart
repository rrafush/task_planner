part of 'task_bloc.dart';

class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class TaskLoadedRequested extends TaskEvent {}

class TaskCreationRequested extends TaskEvent {
  const TaskCreationRequested({
    required this.title,
    required this.description,
    required this.date,
  });
  final String title;
  final String description;
  final DateTime date;
}

class TaskUpdateRequested extends TaskEvent {
  const TaskUpdateRequested({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
  });
  final String id;
  final String title;
  final String description;
  final DateTime date;
}

class TaskDeletionRequested extends TaskEvent {
  const TaskDeletionRequested(this.id);
  final String id;
}
