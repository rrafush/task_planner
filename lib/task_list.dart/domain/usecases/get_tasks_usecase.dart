import 'package:simple_to_do_app/task_list.dart/data/repository.dart';
import 'package:simple_to_do_app/task_list.dart/domain/entity/task.dart';

abstract class GetTasksUsecase {
  Future<List<Task>> call();
}

class GetTasksUsecaseImpl implements GetTasksUsecase {
  GetTasksUsecaseImpl(this.repository);

  final Repository repository;

  @override
  Future<List<Task>> call() async {
    try {
      return await repository.getTask();
    } catch (e) {
      rethrow;
    }
  }
}
