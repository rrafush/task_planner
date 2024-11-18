import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_to_do_app/task_list.dart/data/repository.dart';
import 'package:simple_to_do_app/task_list.dart/domain/entity/task.dart';
import 'package:simple_to_do_app/task_list.dart/domain/usecases/update_task_usecase.dart';

import '../../../locator_mock.dart';

void main() {
  late final Repository repositoryMock;

  setUpAll(() {
    setupLocatorMock();
    repositoryMock = locator<Repository>();

    registerFallbackValue(
      Task(
        id: '',
        title: '',
        description: '',
        date: DateTime(2024),
      ),
    );

    when(() => repositoryMock.updateTask(any())).thenAnswer(
      (_) => Future.value(),
    );
  });

  test('Should call repository update task', () async {
    final usecase = UpdateTaskUsecaseImpl(repositoryMock);
    final task = Task(
      id: '123',
      title: 'title',
      description: 'description',
      date: DateTime(2024),
    );

    await usecase.call(task);

    verify(() => repositoryMock.updateTask(task)).called(1);
  });
}
