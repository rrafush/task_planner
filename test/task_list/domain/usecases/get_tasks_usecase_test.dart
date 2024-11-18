import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_to_do_app/task_list.dart/data/repository.dart';
import 'package:simple_to_do_app/task_list.dart/domain/entity/task.dart';
import 'package:simple_to_do_app/task_list.dart/domain/usecases/get_tasks_usecase.dart';

import '../../../locator_mock.dart';

void main() {
  late final Repository repositoryMock;
  final taskList = [
    Task(
      id: '123',
      title: 'title',
      description: 'description',
      date: DateTime(2024),
    )
  ];

  setUpAll(() {
    setupLocatorMock();
    repositoryMock = locator<Repository>();

    when(() => repositoryMock.getTask()).thenAnswer(
      (_) => Future.value(taskList),
    );
  });

  test('Should call repository get tasks', () async {
    final usecase = GetTasksUsecaseImpl(repositoryMock);

    final result = await usecase.call();

    verify(() => repositoryMock.getTask()).called(1);
    expect(result, taskList);
  });
}
