import 'package:flutter/material.dart';
import 'package:habitrix/models/habit.dart';

import '../../constants.dart';

class VisualizationScreen extends StatefulWidget {
  final Habit habit;

  VisualizationScreen({required this.habit});

  @override
  _VisualizationScreenState createState() => _VisualizationScreenState();
}

class _VisualizationScreenState extends State<VisualizationScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(50.0),
          ),
        ),
        title: const Text('Statistics',
            style: TextStyle(
              fontSize: 30.0,
            )),
        toolbarHeight: 220,
        backgroundColor: kPrimaryColor,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 30.0,
                    height: 10.0,
                  ),
                  InputChip(
                    selectedColor: Colors.green[800],
                    disabledColor: kPrimaryColor,
                    backgroundColor: kPrimaryColor,
                    label: Text(
                      'Day',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onSelected: (bool value) {},
                  ),
                  SizedBox(
                    width: 15.0,
                    height: 10.0,
                  ),
                  InputChip(
                    selectedColor: Colors.green[800],
                    disabledColor: kPrimaryColor,
                    backgroundColor: kPrimaryColor,
                    label: Text(
                      'Week',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onSelected: (bool value) {},
                  ),
                  SizedBox(
                    width: 15.0,
                    height: 10.0,
                  ),
                  InputChip(
                    selectedColor: Colors.green[800],
                    disabledColor: kPrimaryColor,
                    backgroundColor: kPrimaryColor,
                    label: Text(
                      'Month',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onSelected: (bool value) {},
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
