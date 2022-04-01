import 'package:hive/hive.dart';
part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String taskId;

  @HiveField(1)
  String taskName;

  @HiveField(2)
  DateTime deadline;

  @HiveField(3)
  int difficulty;

  @HiveField(4)
  int importance;

  Task({required this.taskId, required this.taskName, required this.deadline, required this.difficulty, required this.importance});
}