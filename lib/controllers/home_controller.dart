import 'package:habitrix/controllers/habit_controller.dart';
import 'package:habitrix/controllers/task_controller.dart';
import 'package:habitrix/controllers/user_controller.dart';
import 'package:habitrix/models/habit.dart';
import 'package:habitrix/models/habit_entry.dart';
import 'package:habitrix/models/task.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../boxes.dart';

class HomeController{
  HabitController? _habitController;
  TaskController? _taskController;
  UserController? _userController;

  HomeController(){
    _habitController =  HabitController();
    _taskController =  TaskController();
    _userController = UserController();
  }

  HabitController? get getHabitController{
    return _habitController;
  }

  TaskController? get getTaskController{
    return _taskController;
  }

  UserController? get getUserController{
    return _userController;
  }

  void initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TaskAdapter());
    Hive.registerAdapter(HabitAdapter());
    Hive.registerAdapter(HabitEntryAdapter());
    await Hive.openBox<Task>(HiveBoxes.task);
    await Hive.openBox<Habit>(HiveBoxes.habit);
    await Hive.openBox<HabitEntry>(HiveBoxes.habit_entry);
  }

  //TODO: implement initFireBase() and initUtilities()
}