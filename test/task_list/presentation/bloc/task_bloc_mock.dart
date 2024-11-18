import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:simple_to_do_app/task_list.dart/presentation/bloc/task_bloc.dart';

class TaskBlocMock extends MockBloc<TaskEvent, TaskState> implements TaskBloc {}

class TaskFakeState extends Fake implements TaskState {}

class TaskFakeEvent extends Fake implements TaskEvent {}

void registerFallbackValues() {
  registerFallbackValue(TaskFakeState());
  registerFallbackValue(TaskFakeEvent());
}

TaskBloc defineBloc({
  TaskState? newState,
}) {
  final blocMock = TaskBlocMock();

  whenListen(
    blocMock,
    Stream.fromIterable([newState ?? TaskInitial()]),
    initialState: newState ?? TaskInitial(),
  );

  return blocMock;
}
