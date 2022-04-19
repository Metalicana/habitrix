import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'habit_entry.g.dart';

@HiveType(typeId: 2)
class HabitEntry extends HiveObject {
  @HiveField(0)
  String habitId;

  @HiveField(1)
  DateTime entryDate;

  @HiveField(2)
  double entryAmount;

  String get getHabitId{
    return habitId;
  }

  DateTime get getEntryDate{
    return entryDate;
  }

  double get getEntryAmount{
    return entryAmount;
  }

  set setHabitId(String newId){
    habitId = newId;
  }

  set setEntryDate(DateTime newDate){
    entryDate = newDate;
  }

  set setEntryAmount(double newAmount){
    entryAmount = newAmount;
  }

  HabitEntry({required this.habitId, required this.entryDate, required this.entryAmount});

}