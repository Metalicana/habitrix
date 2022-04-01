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

  Habit({required this.habitId, required this.habitName, required this.type, required this.unit});
}