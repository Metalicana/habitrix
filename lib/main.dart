import 'package:flutter/material.dart';
import 'package:habitrix/constants.dart';
import 'package:habitrix/screens/habit/habitAdd/habitAddForm.dart';
import 'package:habitrix/screens/habit/habitEdit/habitEditForm.dart';
import 'package:habitrix/screens/home/homeScreen.dart';
import 'package:habitrix/screens/login/loginScreen.dart';
import 'package:habitrix/screens/register/registerScreen.dart';
import 'package:habitrix/screens/task/taskAdd/taskAddForm.dart';
import 'package:habitrix/screens/task/taskItem.dart';
import 'package:habitrix/screens/task/taskList/taskList.dart';
import 'package:habitrix/screens/task/taskList/taskListScreen.dart';
import 'package:habitrix/screens/wrapper.dart';
import 'package:habitrix/screens/habit/habitList/habitListScreen.dart';
import 'package:habitrix/services/auth.dart';
import 'models/habitrixUser.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:habitrix/models/task.dart';
import 'package:habitrix/models/habit.dart';
import 'package:habitrix/models/habit_entry.dart';
import 'package:habitrix/boxes.dart';
import 'package:habitrix/screens/visualize/test.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(HabitAdapter());
  Hive.registerAdapter(HabitEntryAdapter());
  await Hive.openBox<Task>(HiveBoxes.task);
  await Hive.openBox<Habit>(HiveBoxes.habit);
  await Hive.openBox<HabitEntry>(HiveBoxes.habit_entry);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return StreamProvider<HabitrixUser>.value(
      value: AuthService().user,
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'habitrix',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kBackgroundColor,
      ),
        home: Wrapper(),
      )
    );
  }
}
