import 'package:flutter/material.dart';
import 'package:habitrix/models/habit.dart';
import 'package:habitrix/models/task.dart';
import 'package:habitrix/screens/task/taskAdd/taskAddForm.dart';
import 'package:habitrix/screens/task/taskList/taskList.dart';
import 'package:habitrix/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:habitrix/constants.dart';

import '../habitItem.dart';

class HabitListScreen extends StatelessWidget {
  final AuthService _auth = AuthService();


  @override
  Widget build(BuildContext context) {



    Habit x = Habit(habitId: '123', habitName: 'Running', type: 'good', unit: 'kilometers');
    Habit y = Habit(habitId: '1223', habitName: 'Smoking', type: 'bad', unit: 'cigarettes');
    Habit z = Habit(habitId: '1231', habitName: 'Reading', type: 'good', unit: 'minutes');
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
              'Habits',
              style: TextStyle(
                fontSize: 30.0,
              )
          ),
          toolbarHeight: 220,
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
                children: <Column>[
                  Column(
                    children: <Widget>[
                      SizedBox(height: 20.0)
                    ],
                  ),
                  Column(
                    children: <StatefulWidget>[
                      HabitItem(habit:x),
                      HabitItem(habit:y),
                      HabitItem(habit:z),
                    ],
                  )
                ]

            )
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
