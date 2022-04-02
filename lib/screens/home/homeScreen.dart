import 'package:flutter/material.dart';
import 'package:habitrix/constants.dart';
import 'package:habitrix/screens/home/components/background.dart';
import 'package:habitrix/services/auth.dart';


class HomeScreen extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
          title: const Text('Welcome to Habitrix'),
          toolbarHeight: 100,
          backgroundColor: kPrimaryColor,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.logout),
              tooltip: 'logout',
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ],
      ),
      body: Background(

        child: SingleChildScrollView(

          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.1),
              const Text(
                "Quantify, Organize, Evaluate",
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
                      Container(

                        child: IconButton(

                            onPressed: (){},
                            iconSize: 180.0,
                            icon: Image.asset('assets/images/business _ presentation, graph, chart, project, analytics, statistics, woman, people.png')
                        ),
                      ),
                      SizedBox(height: size.height * 0.04),
                      const Text(
                          'Manage your habits'
                      )
                    ],

                  ),

                  SizedBox(width: size.height * 0.018),
                  Column(
                    children: <Widget>[
                      Container(
                        child: IconButton(
                            onPressed: (){},
                            iconSize: 180.0,
                            icon: Image.asset('assets/images/e-commerce _ service, receipt, document, confirm, complete, checkmark, server, waiter.png')
                        ),
                      ),
                      SizedBox(height: size.height * 0.04),
                      const Text(
                          'Track your tasks'
                      ),

                    ],
                  ),

                ],

              ),



            ],
          ),
        ),
      ),
    );
  }
}
