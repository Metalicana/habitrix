import 'package:flutter/material.dart';
import 'package:habitrix/screens/login/components/background.dart';
import 'package:habitrix/constants.dart';
// import 'package:flutter_auth/Screens/Signup/signup_screen.dart';
// import 'package:flutter_auth/components/already_have_an_account_acheck.dart';
// import 'package:flutter_auth/components/rounded_button.dart';
// import 'package:flutter_auth/components/rounded_input_field.dart';
// import 'package:flutter_auth/components/rounded_password_field.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(

      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Login to Habitrix",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                  fontSize: 20,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Image.asset(
              "assets/images/business _ graph, chart, analytics, statistics, presentation, project, woman, people.png",
              height: size.height * 0.35,
            ),
           SizedBox(height: size.height * 0.03),
            Container(
              width: 300.0,
              child: TextFormField(
                cursorColor: Colors.green,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(color: Colors.lightGreen, width: 2.0),

                    )

                ),
                onSaved: (String? value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
                validator: (String? value) {
                  return null;
                },
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Container(
              width: 300.0,
              child: TextFormField(
                cursorColor: Colors.green,
                obscureText: true,
                decoration: InputDecoration(

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(color: Colors.lightGreenAccent, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(color: Colors.lightGreen, width: 2.0),

                  )

                ),
                onSaved: (String? value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
                validator: (String? value) {
                  return null;
                },
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Container(
              width: 300.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),

                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[

                    Positioned.fill(

                      child: Container(
                        decoration: const BoxDecoration(
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(16.0),
                        primary: Colors.white,
                        textStyle: const TextStyle(fontSize: 20),

                      ),
                      onPressed: () {},
                      child: const Text('Login'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: size.height * 0.01),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 14),
              ),
              onPressed: () {},
              child: const Text(
                  'Don\'t have an account? Register',
                  style: TextStyle(
                    color: Colors.green,
                  ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}