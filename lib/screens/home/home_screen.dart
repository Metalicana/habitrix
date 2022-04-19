import 'package:flutter/material.dart';
import 'package:habitrix/constants.dart';
import 'package:habitrix/controllers/home_controller.dart';
import 'package:habitrix/screens/habit/habitList/habit_list_screen.dart';
import 'package:habitrix/screens/home/components/background.dart';
import 'package:habitrix/screens/task/taskList/task_list_screen.dart';
import 'package:habitrix/services/auth.dart';


class HomeScreen extends StatelessWidget {

  final AuthService _auth = AuthService();
  final HomeController mainController;
  HomeScreen({required this.mainController});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
          title: const Text(
              'Habitrix',
            style: TextStyle(
              fontSize: 30.0
            ),
          ),
          toolbarHeight: 220,
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(50.0),
          ),
        ),
          backgroundColor: kPrimaryColor,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.logout),
              tooltip: 'logout',
              onPressed: () async {
                await mainController.getUserController!.signOut();
              },
            ),
          ],
      ),
      body: Background(

        child: SingleChildScrollView(

          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.05),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(

                          child: IconButton(

                              onPressed: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>  HabitListScreen(mainController: mainController,)),
                                );
                              },
                              iconSize: 140.0,
                              icon: Image.asset('assets/images/business _ presentation, graph, chart, project, analytics, statistics, woman, people.png')
                          ),
                        ),
                        SizedBox(height: size.height * 0.04),
                        const Text(
                            'Manage your habits',
                            style: TextStyle(
                              color: kPrimaryColor,
                                fontSize: 15.0
                            ),
                        ),
                        SizedBox(height: 10,)
                      ],

                    ),
                  ),

                  SizedBox(width: size.height * 0.018),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: IconButton(
                              onPressed: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => TaskListScreen(mainController: mainController,)),
                                );
                              },
                              iconSize: 140.0,
                              icon: Image.asset('assets/images/e-commerce _ service, receipt, document, confirm, complete, checkmark, server, waiter.png')
                          ),
                        ),
                        SizedBox(height: size.height * 0.04),
                        const Text(
                          'Track your tasks',
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 15.0
                          ),
                        ),
                        SizedBox(height: 10.0,)

                      ],
                    ),
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
