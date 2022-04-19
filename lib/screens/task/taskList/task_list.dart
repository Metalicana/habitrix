import 'package:flutter/material.dart';
import 'package:habitrix/controllers/home_controller.dart';
import 'package:habitrix/models/task.dart';
import 'package:hive/hive.dart';
import '../task_item.dart';

class TaskList extends StatefulWidget {
  late final Box<Task> box;
  final HomeController mainController;
  TaskList({required this.box, required this.mainController });
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    // var tasks = widget.box.values.toList();
    // tasks.sort();
    var tasks = widget.mainController.getTaskController!.getTaskList();
    return ListView.builder(
      itemCount: widget.box.values.length,
      itemBuilder: (context, index){
        Task task = tasks[index];
        return TaskItem(task: task, mainController: widget.mainController,);
      },
    );
  }
}
