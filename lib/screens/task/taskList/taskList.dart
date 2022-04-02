import 'package:flutter/material.dart';
import 'package:habitrix/constants.dart';
import 'package:habitrix/models/task.dart';
import 'package:provider/provider.dart';

import '../taskItem.dart';
import 'components/background.dart';

class TaskList extends StatefulWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<List<Task>>(context) ?? [];

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index){
        return TaskItem(task: tasks[index]);
      },
    );
  }
}
