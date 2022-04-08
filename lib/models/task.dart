import 'package:hive/hive.dart';
part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject implements Comparable<Task>{
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

  @override
  int compareTo(Task other){
    if(deadline.isBefore(other.deadline)){
      return -1;
    }
    else if(deadline.isAfter(other.deadline)){
      return 1;
    }
    else{
      if(importance>other.importance){
        return -1;
      }
      else if(importance<other.importance){
        return 1;
      }
      else
        {
            if(difficulty>other.difficulty){
              return -1;
            }
            else if(difficulty<other.difficulty){
              return 1;
            }
            else
              {
                if(taskName.compareTo(other.taskName)<0){
                  return -1;
                }
                else if(taskName.compareTo(other.taskName)>0){
                  return 1;
                }
                else{
                  return 0;
                }
              }
        }
    }
  }

  Task({ required this.taskName, required this.deadline, required this.difficulty, required this.importance});


}