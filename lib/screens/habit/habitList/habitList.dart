import 'package:flutter/material.dart';
import 'package:habitrix/constants.dart';
import 'package:habitrix/models/habit.dart';
import 'package:habitrix/models/task.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../habitItem.dart';
import 'components/background.dart';

class HabitList extends StatefulWidget {
  late final Box<Habit> box;
  HabitList({required this.box });


  @override
  _HabitListState createState() => _HabitListState();
}

class _HabitListState extends State<HabitList> {
  @override
  Widget build(BuildContext context) {
    var habits = widget.box.values.toList();
    return ListView.builder(
      itemCount: widget.box.values.length,
      itemBuilder: (context, index){
        Habit? habit = habits[index];
        return HabitItem(habit: habit!);
      },
    );
  }
}
