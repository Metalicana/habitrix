import 'package:flutter/material.dart';
import 'package:habitrix/constants.dart';
import 'package:habitrix/screens/home/homeScreen.dart';
import 'package:habitrix/screens/login/loginScreen.dart';
import 'package:habitrix/screens/register/registerScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'habitrix',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kBackgroundColor,

      ),
      home: HomeScreen(),
    );
  }
}
