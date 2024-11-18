import 'package:simple_to_do_app/task_list.dart/data/repository.dart';

abstract class DeleteTaskUsecase {
  Future<void> call(String id);
}

class DeleteTaskUsecaseImpl implements DeleteTaskUsecase {
  DeleteTaskUsecaseImpl(this.repository);

  final Repository repository;

  @override
  Future<void> call(String id) async {
    try {
      await repository.deleteTask(id);
    } catch (e) {
      rethrow;
    }
  }
}
