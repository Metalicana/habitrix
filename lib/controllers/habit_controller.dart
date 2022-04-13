import 'package:habitrix/models/habit.dart';
import 'package:habitrix/models/habit_entry.dart';
import 'package:hive/hive.dart';

import '../boxes.dart';

class HabitController{
  List<Habit> _habitList = List.empty();

  HabitController(){
    _habitList = Hive.box<Habit>(HiveBoxes.habit).values.toList();
  }

  void addHabit(Habit habit){
    Box<Habit> habitBox = Hive.box<Habit>(HiveBoxes.habit);
    habitBox.add(habit);
    _habitList.add(habit);
  }

  void removeHabit(Habit habit){
    habit.delete();
    _habitList.remove(habit);
  }

  void editHabit(Habit oldHabit, Habit editedHabit){
    removeHabit(oldHabit);
    addHabit(editedHabit);
  }


  Habit? getHabit(int index){
    if(_habitList.length<=index) return null;
    return _habitList[index];
  }

  List<HabitEntry> getHabitEntries(Habit habit){
    String currentHabitId = habit.habitId;
    var hiveBox = Hive.box<HabitEntry>(HiveBoxes.habit_entry);
    List<HabitEntry> relevantEntries = hiveBox.values.where( (entry) => entry.getHabitId.compareTo(currentHabitId)==0).toList();
    return relevantEntries;
  }

  List<Habit> getHabitList(){
    return _habitList;
  }
}