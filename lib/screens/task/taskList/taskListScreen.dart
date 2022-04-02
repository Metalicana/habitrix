import 'package:flutter/material.dart';
import 'package:habitrix/models/task.dart';
import 'package:habitrix/screens/task/taskList/taskList.dart';
import 'package:habitrix/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:habitrix/constants.dart';
import '../taskItem.dart';

class TaskListScreen extends StatelessWidget {
  final AuthService _auth = AuthService();


  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime(1999);
    Task a = Task(taskId: '1202', taskName: 'Kiss Homies goodnight', deadline: date, importance: 5 ,difficulty:  5);
    Task b = Task(taskId: '21', taskName: 'Read bible', deadline: date, importance: 5 ,difficulty:  5);
    Task c = Task(taskId: '413', taskName: 'Play skyrim', deadline: date, importance: 5 ,difficulty:  5);
    return Container(
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: const Text('Tasks'),
          toolbarHeight: 100,
          backgroundColor: kPrimaryColor,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.logout),
              tooltip: 'logout',
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/coffee_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child : Column(
              children: <StatefulWidget>[
                TaskItem(task:a),
                TaskItem(task:b),
                TaskItem(task:c),
              ],
            )
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: kPrimaryColor,
            child: const Icon(Icons.add),
            onPressed: (){}
        ),
      ),
    );
  }
}
