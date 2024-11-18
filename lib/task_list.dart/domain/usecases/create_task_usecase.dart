import 'package:simple_to_do_app/task_list.dart/data/repository.dart';
import 'package:simple_to_do_app/task_list.dart/domain/entity/task.dart';

abstract class CreateTaskUsecase {
  Future<void> call(Task task);
}

class CreateTaskUsecaseImpl implements CreateTaskUsecase {
  CreateTaskUsecaseImpl(this.repository);

  final Repository repository;

  @override
  Future<void> call(Task task) async {
    try {
      await repository.createTask(task);
    } catch (e) {
      rethrow;
    }
  }
}
