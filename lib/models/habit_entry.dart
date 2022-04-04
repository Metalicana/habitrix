import 'package:hive/hive.dart';
part 'habit_entry.g.dart';

@HiveType(typeId: 2)
class HabitEntry extends HiveObject {
  @HiveField(0)
  String habitId;

  @HiveField(1)
  DateTime entryDate;

  @HiveField(2)
  double entryAmount;

  HabitEntry({required this.habitId, required this.entryDate, required this.entryAmount});
}