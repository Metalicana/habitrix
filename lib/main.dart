import 'package:flutter/material.dart';
import 'package:habitrix/constants.dart';
import 'package:habitrix/controllers/home_controller.dart';
import 'package:habitrix/screens/wrapper.dart';
import 'models/habitrix_user.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:habitrix/models/task.dart';
import 'package:habitrix/models/habit.dart';
import 'package:habitrix/models/habit_entry.dart';
import 'package:habitrix/boxes.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(HabitAdapter());
  Hive.registerAdapter(HabitEntryAdapter());
  await Hive.openBox<Task>(HiveBoxes.task);
  await Hive.openBox<Habit>(HiveBoxes.habit);
  await Hive.openBox<HabitEntry>(HiveBoxes.habit_entry);
  HomeController mainController = HomeController();
  runApp( MyApp(metaController: mainController));
}

class MyApp extends StatelessWidget {
  MyApp({required this.metaController});
  final HomeController metaController;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return StreamProvider<HabitrixUser>.value(
      value: metaController.getUserController!.getUser(),
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'habitrix',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kBackgroundColor,
      ),
        home: Wrapper(mainController: metaController),
      )
    );
  }
}
