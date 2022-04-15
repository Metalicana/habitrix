import 'package:flutter/material.dart';
import 'package:habitrix/models/task.dart';
import 'package:habitrix/screens/task/taskAdd/taskAddForm.dart';
import 'package:habitrix/screens/task/taskList/taskList.dart';
import 'package:habitrix/services/auth.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:habitrix/constants.dart';
import '../../../boxes.dart';
import '../taskItem.dart';

class TaskListScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    // DateTime date = DateTime(1999);
    // Task a = Task( taskName: 'Kiss Homies goodnight', deadline: date, importance: 5 ,difficulty:  5);
    // Task b = Task( taskName: 'Read bible', deadline: date, importance: 5 ,difficulty:  5);
    // Task c = Task( taskName: 'Play skyrim', deadline: date, importance: 5 ,difficulty:  5);
    return Container(
      child: Scaffold(
        backgroundColor: Color(0xFFf4f7f2),
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(50.0),
            ),
          ),
          title: const Text(
              'Tasks',
            style: TextStyle(
              fontSize: 30.0,
            )
          ),
          toolbarHeight: 220,
          backgroundColor: kPrimaryColor,

        ),
        body: ValueListenableBuilder(
          valueListenable: Hive.box<Task>(HiveBoxes.task).listenable(),
          builder: (BuildContext context, Box<Task> box, _) {
            return TaskList( box: box);
          },


        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: kPrimaryColor,
            child: const Icon(Icons.add),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TaskAddForm()),
              );
            }
        ),
      ),
    );
  }
}
