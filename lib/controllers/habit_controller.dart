import 'package:habitrix/models/habit.dart';
import 'package:habitrix/models/habit_entry.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

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

  void addHabitEntry(HabitEntry entry){
    Box<HabitEntry> habitEntryBox = Hive.box<HabitEntry>(HiveBoxes.habit_entry);
    habitEntryBox.add(entry);
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

  DateTime? firstEntryDate(Habit habit){
    DateTime answer = DateTime.now();
    List<HabitEntry> relevantEntries = getHabitEntries(habit);
    if(relevantEntries.isEmpty)
    {
      return null;
    }
    for(HabitEntry currentEntry in relevantEntries)
    {
      DateTime currentEntryDate = currentEntry.getEntryDate;
      if(currentEntryDate.isBefore(answer)) answer = currentEntryDate;
    }
    return answer;
  }

  /// Calculates number of days between two dates
  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (from.difference(to).inHours / 24).round();
  }

  /// Calculates number of weeks for a given year as per https://en.wikipedia.org/wiki/ISO_week_date#Weeks_per_year
  int numOfWeeks(int year) {
    DateTime dec28 = DateTime(year, 12, 28);
    int dayOfDec28 = int.parse(DateFormat("D").format(dec28));
    return ((dayOfDec28 - dec28.weekday + 10) / 7).floor();
  }

  /// Calculates week number from a date as per https://en.wikipedia.org/wiki/ISO_week_date#Calculation
  int weekNumber(DateTime date) {
    int dayOfYear = int.parse(DateFormat("D").format(date));
    int woy =  ((dayOfYear - date.weekday + 10) / 7).floor();
    if (woy < 1) {
      woy = numOfWeeks(date.year - 1);
    } else if (woy > numOfWeeks(date.year)) {
      woy = 1;
    }
    return woy;
  }

  List<double> dailyHabitEntries(Habit habit){
    DateTime now = DateTime.now();
    DateTime? start = firstEntryDate(habit);
    if(start==null){
      return List.empty();
    }
    int differenceInDays = daysBetween(now, start);
    List<HabitEntry> relevantEntries = getHabitEntries(habit);
    List<double> recordsList = List<double>.filled(differenceInDays+5, 0);
    for(HabitEntry currentEntry in relevantEntries){
      DateTime currentEntryDate = currentEntry.getEntryDate;
      differenceInDays = daysBetween(now,currentEntryDate);
      recordsList[differenceInDays]+=currentEntry.getEntryAmount;
    }
    return recordsList;
  }

  List<double> weeklyHabitEntries(Habit habit){
    DateTime now = DateTime.now();
    DateTime? start = firstEntryDate(habit);
    if(start==null){
      return List.empty();
    }

    int startingWeekNumber = weekNumber(start);
    int endingWeekNumber = weekNumber(now);
    int startingYear = start.year;
    int endingYear = now.year;

    if(startingYear==endingYear){
      int totalWeeksToShow = endingWeekNumber-startingWeekNumber+1;
      List<double> recordsList = List<double>.filled(totalWeeksToShow, 0);
      var hiveBox = Hive.box<HabitEntry>(HiveBoxes.habit_entry);
      List<HabitEntry> entriesFromStartingYear = hiveBox.values.where( (entry) => entry.getHabitId.compareTo(habit.getHabitId)==0 && entry.getEntryDate.year==startingYear).toList();
      for(HabitEntry currentEntry in entriesFromStartingYear){
        int numOfWeek = weekNumber(currentEntry.getEntryDate);
        recordsList[numOfWeek-startingWeekNumber]+=currentEntry.getEntryAmount;
      }
      return recordsList;
    }

    int totalWeeksInStartingYear = numOfWeeks(start.year);
    int weeksToShowFromStartingYear = totalWeeksInStartingYear - startingWeekNumber + 1;
    int totalWeeksToShow = weeksToShowFromStartingYear + endingWeekNumber;
    for(int currentYear = startingYear+1; currentYear<endingYear; currentYear++){
      totalWeeksToShow+=numOfWeeks(currentYear);
    }

    List<double> recordsList = List<double>.filled(totalWeeksToShow, 0);
    var hiveBox = Hive.box<HabitEntry>(HiveBoxes.habit_entry);
    List<HabitEntry> entriesFromStartingYear = hiveBox.values.where( (entry) => entry.getHabitId.compareTo(habit.getHabitId)==0 && entry.getEntryDate.year==startingYear).toList();

    for(HabitEntry currentEntry in entriesFromStartingYear){
      int numOfWeek = weekNumber(currentEntry.getEntryDate);
      recordsList[numOfWeek-startingWeekNumber]+=currentEntry.getEntryAmount;
    }
    int offset = weeksToShowFromStartingYear-1;

    for(int currentYear = startingYear+1; currentYear<=endingYear; currentYear++){
      List<HabitEntry> entriesFromCurrentYear = hiveBox.values.where( (entry) => entry.getHabitId.compareTo(habit.getHabitId)==0 && entry.getEntryDate.year==currentYear).toList();
      for(HabitEntry currentEntry in entriesFromCurrentYear){
        int numOfWeek = weekNumber(currentEntry.getEntryDate);
        recordsList[offset+numOfWeek]+=currentEntry.getEntryAmount;
      }
      if(currentYear!=endingYear){
        offset+=numOfWeeks(currentYear);
      }
      else{
        offset+=endingWeekNumber;
      }
    }
    return recordsList;
  }

  List<double> monthlyHabitEntries(Habit habit){
    DateTime now = DateTime.now();
    DateTime? start = firstEntryDate(habit);
    if(start==null){
      return List.empty();
    }

    int startingYear = start.year;
    int endingYear = now.year;
    int startingMonthNumber = start.month;
    int endingMonthNumber = now.month;

    if(startingYear==endingYear){
      int totalMonthsToShow = endingMonthNumber-startingMonthNumber+1;
      List<double> recordsList = List<double>.filled(totalMonthsToShow, 0);
      var hiveBox = Hive.box<HabitEntry>(HiveBoxes.habit_entry);
      List<HabitEntry> entriesFromStartingYear = hiveBox.values.where( (entry) => entry.getHabitId.compareTo(habit.getHabitId)==0 && entry.getEntryDate.year==startingYear).toList();
      for(HabitEntry currentEntry in entriesFromStartingYear){
        int numOfMonth = currentEntry.getEntryDate.month;
        recordsList[numOfMonth-startingMonthNumber]+=currentEntry.getEntryAmount;
      }
      return recordsList;
    }

    int monthsToShowFromStartingYear = 12 - startingMonthNumber + 1;
    int totalMonthsToShow = monthsToShowFromStartingYear + endingMonthNumber;
    for(int currentYear = startingYear + 1; currentYear<endingYear; currentYear++)
    {
      totalMonthsToShow+=12;
    }

    List<double> recordsList = List<double>.filled(totalMonthsToShow, 0);

    var hiveBox = Hive.box<HabitEntry>(HiveBoxes.habit_entry);
    List<HabitEntry> entriesFromStartingYear = hiveBox.values.where( (entry) => entry.getHabitId.compareTo(habit.getHabitId)==0 && entry.getEntryDate.year==startingYear).toList();

    for(HabitEntry currentEntry in entriesFromStartingYear){
      int monthNumber = currentEntry.getEntryDate.month;
      recordsList[startingMonthNumber-monthNumber]+=currentEntry.getEntryAmount;
    }
    int offset = monthsToShowFromStartingYear-1;

    for(int currentYear = startingYear+1; currentYear<=endingYear; currentYear++){
      List<HabitEntry> entriesFromCurrentYear = hiveBox.values.where( (entry) => entry.getHabitId.compareTo(habit.getHabitId)==0 && entry.getEntryDate.year==currentYear).toList();
      for(HabitEntry currentEntry in entriesFromCurrentYear){
        int numOfMonth = currentEntry.getEntryDate.month;
        recordsList[offset+numOfMonth]+=currentEntry.getEntryAmount;
      }
      if(currentYear!=endingYear){
        offset+=12;
      }
      else{
        offset+=endingMonthNumber;
      }
    }
    return recordsList;
  }
}