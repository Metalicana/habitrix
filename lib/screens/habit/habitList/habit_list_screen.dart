import 'package:flutter/material.dart';
import 'package:habitrix/controllers/home_controller.dart';
import 'package:habitrix/models/habit.dart';
import 'package:habitrix/screens/habit/habitAdd/habit_add_form.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:habitrix/constants.dart';
import '../../../boxes.dart';
import 'habit_list.dart';

class HabitListScreen extends StatelessWidget {
  final HomeController mainController;
  HabitListScreen({required this.mainController});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Color(0xFFf4f7f2),
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(50.0),
            ),
          ),
          title: const Text('Habits',
              style: TextStyle(
                fontSize: 30.0,
              )),
          toolbarHeight: 220,
          backgroundColor: kPrimaryColor,
        ),
        body: ValueListenableBuilder(
            valueListenable: Hive.box<Habit>(HiveBoxes.habit).listenable(),
            builder: (BuildContext context, Box<Habit> box, _) {
              return HabitList(box: box, mainController: mainController,);
            }),
        floatingActionButton: FloatingActionButton(
            backgroundColor: kPrimaryColor,
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  HabitAddForm(mainController: mainController )),
              );
            }),
      ),
    );
  }
}
