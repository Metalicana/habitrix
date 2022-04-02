import 'package:habitrix/screens/home/homeScreen.dart';
import 'package:habitrix/models/habitrixUser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authenticate.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<HabitrixUser>(context);

    // return either the Home or Authenticate widget
    if (user == null){
      return Authenticate();
    } else {
      return HomeScreen();
    }

  }
}