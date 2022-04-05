import 'package:hive/hive.dart';
part 'habit.g.dart';

@HiveType(typeId: 1)
class Habit extends HiveObject {
  @HiveField(0)
  String habitId;

  @HiveField(1)
  String habitName;

  @HiveField(2)
  String type;

  @HiveField(3)
  String unit;

  String get getHabitId{
    return habitId;
  }

  String get getHabitName{
    return habitName;
  }

  String get getType{
    return type;
  }

  String get getUnit{
    return unit;
  }

  set setHabitId(String newId){
    habitId = newId;
  }

  set setHabitName(String newName){
    habitName = newName;
  }

  set setType(String newType){
    type = newType;
  }

  set setUnit(String newUnit){
    unit = newUnit;
  }

  Habit({required this.habitId, required this.habitName, required this.type, required this.unit});
}