import 'package:flutter/material.dart';
import 'package:habitrix/constants.dart';
import 'package:habitrix/models/habit.dart';
import 'package:habitrix/models/task.dart';
import 'package:provider/provider.dart';

import '../habitItem.dart';
import 'components/background.dart';

class HabitList extends StatefulWidget {
  const HabitList({Key? key}) : super(key: key);

  @override
  _HabitListState createState() => _HabitListState();
}

class _HabitListState extends State<HabitList> {
  @override
  Widget build(BuildContext context) {
    final habits = Provider.of<List<Habit>>(context) ?? [];

    return ListView.builder(
      itemCount: habits.length,
      itemBuilder: (context, index){
        return HabitItem(habit: habits[index]);
      },
    );
  }
}
