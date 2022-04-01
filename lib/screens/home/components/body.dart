import 'package:flutter/material.dart';
import 'package:habitrix/screens/home/components/background.dart';
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
              "Welcome to Habitrix!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
                fontSize: 20,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Image.asset(
                      "assets/images/business _ presentation, graph, chart, project, analytics, statistics, woman, people.png",
                      height: size.height * 0.35,
                      width: size.width * 0.4,

                    ),
                    const Text(
                      'Manage your habits'
                    )
                  ],

                ),

                SizedBox(width: size.height * 0.095),
                Column(
                  children: <Widget>[
                    Image.asset(

                      "assets/images/e-commerce _ service, receipt, document, confirm, complete, checkmark, server, waiter.png",
                      height: size.height * 0.35,
                      width: size.width * 0.4,
                    ),
                    const Text(
                        'Track your tasks'
                    )
                  ],
                ),

              ],
            ),



          ],
        ),
      ),
    );
  }
}