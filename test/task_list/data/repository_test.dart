import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_to_do_app/task_list.dart/data/model/task_model.dart';
import 'package:simple_to_do_app/task_list.dart/data/repository.dart';
import 'package:simple_to_do_app/task_list.dart/domain/entity/task.dart';
import 'package:simple_to_do_app/shared/utils/adapters/shared_preferences_adapter.dart';

import '../../locator_mock.dart';

void main() {
  late final SharedPreferencesAdapter sharedPreferencesAdapterMock;
  setUpAll(() {
    setupLocatorMock();
    sharedPreferencesAdapterMock = locator<SharedPreferencesAdapter>();
  });

  test(
      'when getToDos is called then it should call shared preferences returning data',
      () {
    when(() => sharedPreferencesAdapterMock.getData()).thenAnswer(
      (_) async => List<Map<String, dynamic>>.empty(),
    );

    final sut = RepositoryImpl();
    final result = sut.getTask();
    expect(result, completes);

    verify(() => sharedPreferencesAdapterMock.getData()).called(1);
  });

  test(
      'when createToDo is called then it should call shared preferences with the right data',
      () {
    when(() => sharedPreferencesAdapterMock.setData(any(), any())).thenAnswer(
      (_) => Future.value(),
    );

    final todo = Task(
      id: '123',
      title: 'title',
      description: 'description',
      date: DateTime(2024),
    );

    final sut = RepositoryImpl();
    final result = sut.createTask(todo);
    expect(result, completes);

    final todoJson = TaskModel.fromEntity(todo).toJson();

    verify(() => sharedPreferencesAdapterMock.setData('123', todoJson))
        .called(1);
  });

  test(
      'when updateToDo is called then it should call shared preferences with the new data',
      () {
    //ignore: unused_element
    fakeAsync(async) {
      when(() => sharedPreferencesAdapterMock.setData(any(), any())).thenAnswer(
        (_) => Future.value(),
      );

      final todo = Task(
        id: '123',
        title: 'title',
        description: 'description',
        date: DateTime(2024),
      );

      final sut = RepositoryImpl();
      final result = sut.updateTask(todo);
      expect(result, completes);

      async.elapse(const Duration(seconds: 1));
      final todoJson = TaskModel.fromEntity(todo).toJson();

      verifyNever(() => sharedPreferencesAdapterMock.removeData('123'));

      verify(() => sharedPreferencesAdapterMock.setData('123', todoJson))
          .called(1);
    }
  });

  test(
      'when deleteToDo is called then it should call shared preferences deleting the data',
      () {
    when(() => sharedPreferencesAdapterMock.removeData(any())).thenAnswer(
      (_) => Future.value(),
    );

    final todo = Task(
      id: '123',
      title: 'title',
      description: 'description',
      date: DateTime(2024),
    );

    final sut = RepositoryImpl();
    final result = sut.deleteTask(todo.id);
    expect(result, completes);

    verify(() => sharedPreferencesAdapterMock.removeData('123')).called(1);
  });
}
