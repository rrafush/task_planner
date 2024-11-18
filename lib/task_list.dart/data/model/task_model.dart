import 'package:equatable/equatable.dart';
import 'package:simple_to_do_app/task_list.dart/domain/entity/task.dart';

final class TaskModel extends Equatable {
  const TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
  });

  final String id;
  final String title;
  final String description;
  final DateTime date;

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        date: DateTime.parse(json["date"] ?? DateTime.now().toIso8601String()),
      );

  factory TaskModel.fromEntity(Task task) => TaskModel(
        id: task.id,
        title: task.title,
        description: task.description,
        date: task.date,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "date": date.toIso8601String(),
      };

  Task toEntity() => Task(
        id: id,
        title: title,
        description: description,
        date: date,
      );

  @override
  String toString() {
    return 'TaskModel{id: $id, title: $title, description: $description}, date: $date';
  }

  @override
  List<Object> get props => [
        id,
        title,
        description,
        date,
      ];
}
