import 'package:simple_to_do_app/task_list.dart/data/repository.dart';
import 'package:simple_to_do_app/task_list.dart/domain/entity/task.dart';

abstract class UpdateTaskUsecase {
  Future<void> call(Task task);
}

class UpdateTaskUsecaseImpl implements UpdateTaskUsecase {
  UpdateTaskUsecaseImpl(this.repository);

  final Repository repository;

  @override
  Future<void> call(Task task) async {
    try {
      await repository.updateTask(task);
    } catch (e) {
      rethrow;
    }
  }
}
