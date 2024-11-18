import 'package:simple_to_do_app/locator.dart';
import 'package:simple_to_do_app/task_list.dart/data/model/task_model.dart';
import 'package:simple_to_do_app/task_list.dart/domain/entity/task.dart';
import 'package:simple_to_do_app/shared/utils/adapters/shared_preferences_adapter.dart';

abstract class Repository {
  Future<List<Task>> getTask();
  Future<void> createTask(Task toDo);
  Future<void> updateTask(Task toDo);
  Future<void> deleteTask(String id);
}

class RepositoryImpl implements Repository {
  final SharedPreferencesAdapter _sharedPreferencesAdapter =
      locator<SharedPreferencesAdapter>();
  @override
  Future<List<Task>> getTask() async {
    final data = await _sharedPreferencesAdapter.getData();
    return data.map((e) => TaskModel.fromJson(e).toEntity()).toList();
  }

  @override
  Future<void> createTask(Task toDo) async {
    await _sharedPreferencesAdapter.setData(
      toDo.id,
      TaskModel.fromEntity(toDo).toJson(),
    );
  }

  @override
  Future<void> updateTask(Task toDo) async {
    final data = TaskModel.fromEntity(toDo).toJson();
    await _sharedPreferencesAdapter.setData(toDo.id, data);
  }

  @override
  Future<void> deleteTask(String id) async {
    await _sharedPreferencesAdapter.removeData(id);
  }
}
