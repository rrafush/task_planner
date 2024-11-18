import 'package:flutter_test/flutter_test.dart';
import 'package:simple_to_do_app/task_list.dart/data/model/task_model.dart';
import 'package:simple_to_do_app/task_list.dart/domain/entity/task.dart';

void main() {
  final json = {
    'id': '123',
    'title': 'title',
    'description': 'description',
    'date': DateTime(2024).toIso8601String(),
  };
  final model = TaskModel(
    id: '123',
    title: 'title',
    description: 'description',
    date: DateTime(2024),
  );

  final entity = Task(
    id: '123',
    title: 'title',
    description: 'description',
    date: DateTime(2024),
  );

  test('Should convert from json to model', () async {
    expect(TaskModel.fromJson(json), model);
  });

  test('Should convert from entity to model', () async {
    expect(TaskModel.fromEntity(entity), model);
  });

  test('Should convert from model to json', () async {
    expect(model.toJson(), json);
  });

  test('Should convert from model to entity', () async {
    expect(model.toEntity(), entity);
  });
}
