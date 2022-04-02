import 'package:habitrix/screens/login/loginScreen.dart';
import 'package:habitrix/screens/register/registerScreen.dart';
import 'package:flutter/material.dart';


class Authenticate extends StatefulWidget {
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
      return LoginScreen(toggleView:  toggleView);
    } else {
      return RegisterScreen(toggleView:  toggleView);
    }
  }
}