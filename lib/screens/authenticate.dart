import 'package:habitrix/controllers/home_controller.dart';
import 'package:habitrix/screens/login/login_screen.dart';
import 'package:habitrix/screens/register/register_screen.dart';
import 'package:flutter/material.dart';


class Authenticate extends StatefulWidget {
  final HomeController mainController;
  Authenticate({required this.mainController});
  @override
  _AuthenticateState createState() => _AuthenticateState();

}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  void toggleView(){
    //print(showSignIn.toString());
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return LoginScreen(toggleView:  toggleView, mainController: widget.mainController,);
    } else {
      return RegisterScreen(toggleView:  toggleView, mainController: widget.mainController,);
    }
  }
}