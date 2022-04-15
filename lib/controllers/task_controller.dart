import 'package:habitrix/models/task.dart';
import 'package:hive/hive.dart';

import '../boxes.dart';

class TaskController{
  List<Task> _taskList = List.empty();

  TaskController(){
    _taskList = Hive.box<Task>(HiveBoxes.task).values.toList();
  }

  void addTask(Task task){
    Box<Task> taskBox = Hive.box<Task>(HiveBoxes.task);
    taskBox.add(task);
    _taskList.add(task);
  }

  void removeTask(Task task){
    task.delete();
    _taskList.remove(task);
  }

  void editTask(Task oldTask, Task editedTask){
    removeTask(oldTask);
    addTask(editedTask);
  }

  void sortTasks(){
    List<Task> listOfTasks = Hive.box<Task>(HiveBoxes.task).values.toList();
    listOfTasks.sort();
    _taskList.sort();
  }

  Task? getTask(int index){
    if(_taskList.length<=index) return null;
    return _taskList[index];
  }

  List<Task> getTaskList(){
    sortTasks();
    return _taskList;
  }
}