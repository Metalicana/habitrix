import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../boxes.dart';
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

  List<HabitEntry> allEntriesList(){
    var hiveBox = Hive.box<HabitEntry>(HiveBoxes.habit_entry);
    List<HabitEntry> relevantEntries = hiveBox.values.where( (entry) => entry.getHabitId.compareTo(habitId)==0).toList();
    return relevantEntries;
  }

  DateTime? firstEntryDate(){
    DateTime answer = DateTime.now();
    List<HabitEntry> relevantEntries = allEntriesList();
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
    return (to.difference(from).inHours / 24).round();
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

  List<double> dailyHabitEntries(){
    DateTime now = DateTime.now();
    DateTime? start = firstEntryDate();
    if(start==null){
        return List.empty();
      }
    int differenceInDays = daysBetween(now, start);
    List<HabitEntry> relevantEntries = allEntriesList();
    List<double> recordsList = List<double>.filled(differenceInDays, 0);
    for(HabitEntry currentEntry in relevantEntries){
        DateTime currentEntryDate = currentEntry.getEntryDate;
        differenceInDays = daysBetween(now,currentEntryDate);
        recordsList[differenceInDays]+=currentEntry.getEntryAmount;
      }
    return recordsList;
  }

  List<double> weeklyHabitEntries(){
    DateTime now = DateTime.now();
    DateTime? start = firstEntryDate();
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
      List<HabitEntry> entriesFromStartingYear = hiveBox.values.where( (entry) => entry.getHabitId.compareTo(habitId)==0 && entry.getEntryDate.year==startingYear).toList();
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
    List<HabitEntry> entriesFromStartingYear = hiveBox.values.where( (entry) => entry.getHabitId.compareTo(habitId)==0 && entry.getEntryDate.year==startingYear).toList();

    for(HabitEntry currentEntry in entriesFromStartingYear){
      int numOfWeek = weekNumber(currentEntry.getEntryDate);
      recordsList[numOfWeek-startingWeekNumber]+=currentEntry.getEntryAmount;
    }
    int offset = weeksToShowFromStartingYear-1;

    for(int currentYear = startingYear+1; currentYear<=endingYear; currentYear++){
      List<HabitEntry> entriesFromCurrentYear = hiveBox.values.where( (entry) => entry.getHabitId.compareTo(habitId)==0 && entry.getEntryDate.year==currentYear).toList();
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

  List<double> monthlyHabitEntries(){
    DateTime now = DateTime.now();
    DateTime? start = firstEntryDate();
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
      List<HabitEntry> entriesFromStartingYear = hiveBox.values.where( (entry) => entry.getHabitId.compareTo(habitId)==0 && entry.getEntryDate.year==startingYear).toList();
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
    List<HabitEntry> entriesFromStartingYear = hiveBox.values.where( (entry) => entry.getHabitId.compareTo(habitId)==0 && entry.getEntryDate.year==startingYear).toList();

    for(HabitEntry currentEntry in entriesFromStartingYear){
      int monthNumber = currentEntry.getEntryDate.month;
      recordsList[startingMonthNumber-monthNumber]+=currentEntry.getEntryAmount;
    }
    int offset = monthsToShowFromStartingYear-1;

    for(int currentYear = startingYear+1; currentYear<=endingYear; currentYear++){
      List<HabitEntry> entriesFromCurrentYear = hiveBox.values.where( (entry) => entry.getHabitId.compareTo(habitId)==0 && entry.getEntryDate.year==currentYear).toList();
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