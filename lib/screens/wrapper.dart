import 'package:habitrix/controllers/home_controller.dart';
import 'package:habitrix/screens/home/home_screen.dart';
import 'package:habitrix/models/habitrix_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authenticate.dart';

class Wrapper extends StatelessWidget {
  Wrapper({required this.mainController});
  final HomeController mainController;
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<HabitrixUser>(context);

    // return either the Home or Authenticate widget
    if (user == null){
      return Authenticate(mainController: mainController);
    } else {
      return HomeScreen(mainController: mainController);
    }

  }
}