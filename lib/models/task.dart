import 'package:hive/hive.dart';
part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String? taskId;

  @HiveField(1)
  String taskName;

  @HiveField(2)
  DateTime deadline;

  @HiveField(3)
  int difficulty;

  @HiveField(4)
  int importance;

  String? get getTaskId{
    return taskId;
  }

  String get getTaskName{
    return taskName;
  }

  DateTime get getDeadline{
    return deadline;
  }


  int get getDifficulty{
    return difficulty;
  }

  int get getImportance{
    return importance;
  }

  set setTaskId(String? newId){
    taskId = newId;
  }

  set setTaskName(String newName){
    taskName = newName;
  }

  set setDeadline(DateTime newDeadline){
    deadline = newDeadline;
  }

  set setImportance(int newImportance){
    importance = newImportance;
  }

  set setDifficulty(int newDifficulty){
    difficulty = newDifficulty;
  }

  Task({ required this.taskName, required this.deadline, required this.difficulty, required this.importance});


}