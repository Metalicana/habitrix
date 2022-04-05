import 'package:flutter/material.dart';
import 'package:habitrix/constants.dart';
import 'package:habitrix/models/task.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../taskItem.dart';
import 'components/background.dart';

class TaskList extends StatefulWidget {
  late final Box<Task> box;
  TaskList({required this.box });
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    var tasks = widget.box.values.toList();
    tasks.sort();
    return ListView.builder(
      itemCount: widget.box.values.length,
      itemBuilder: (context, index){
        Task? task = tasks[index];
        return TaskItem(task: task!);
      },
    );
  }
}
