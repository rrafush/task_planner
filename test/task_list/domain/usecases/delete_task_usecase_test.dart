import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_to_do_app/task_list.dart/data/repository.dart';
import 'package:simple_to_do_app/task_list.dart/domain/usecases/delete_task_usecase.dart';

import '../../../locator_mock.dart';

void main() {
  late final Repository repositoryMock;

  setUpAll(() {
    setupLocatorMock();
    repositoryMock = locator<Repository>();

    when(() => repositoryMock.deleteTask(any())).thenAnswer(
      (_) => Future.value(),
    );
  });

  test('Should call repository delete task', () async {
    final id = '123';

    final usecase = DeleteTaskUsecaseImpl(repositoryMock);
    await usecase.call(id);

    verify(() => repositoryMock.deleteTask(id)).called(1);
  });
}
