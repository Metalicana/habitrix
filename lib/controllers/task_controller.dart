import 'package:habitrix/models/task.dart';
import 'package:hive/hive.dart';

import '../boxes.dart';

class TaskController{
  List<Task> taskList = List.empty();

  TaskController(){
    taskList = Hive.box<Task>(HiveBoxes.task).values.toList();
  }

  void addTask(Task task){
    Box<Task> taskBox = Hive.box<Task>(HiveBoxes.task);
    taskBox.add(task);
  }

  void removeTask(Task task){
    task.delete();
  }

  void editTask(Task oldTask, Task editedTask){
    removeTask(oldTask);
    addTask(editedTask);
  }

  List<Task> sortedTaskList(){
    List<Task> listOfTasks = Hive.box<Task>(HiveBoxes.task).values.toList();
    listOfTasks.sort();
    return listOfTasks;
  }

  Task? getTask(int index){
    if(taskList.length<=index) return null;
    return taskList[index];
  }
}