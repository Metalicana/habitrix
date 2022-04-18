//Stateful widget that will work as a form
//Takes no parameter but after submitting the form
//It should be able to do a database query
import 'package:flutter/material.dart';
import 'package:habitrix/constants.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:habitrix/controllers/home_controller.dart';
import 'package:habitrix/models/habit.dart';
import 'package:habitrix/screens/task/taskList/components/background.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

import '../../../boxes.dart';

class HabitAddForm extends StatefulWidget {
  final HomeController mainController;

  HabitAddForm({required this.mainController});
  @override
  _HabitAddFormState createState() => _HabitAddFormState();
}

class _HabitAddFormState extends State<HabitAddForm> {

  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  // text field state
  String name = '';
  String unit = '';
  DateTime ?deadline = null;
  double importance = 20;
  double difficulty = 20;
  String dropdownValue = 'good';
  validated() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _onFormSubmit();
      print("Form Validated");
    } else {
      print("Form Not Validated");
      return;
    }
  }
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
        title: const Text(
            'Add a new habit',
            style: TextStyle(
              fontSize: 30.0,
            )
        ),
        toolbarHeight: 220,
        backgroundColor: kPrimaryColor,

      ),
      body: Background(

        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.03),
              Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 300.0,
                        child: TextFormField(

                          cursorColor: Colors.green,
                          decoration: InputDecoration(
                              hintText: 'Habit name',
                              icon: Icon(
                                Icons.edit,
                                color: Colors.grey,

                              ),
                              contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: const BorderSide(color: Colors.lightGreen, width: 2.0),

                              )

                          ),
                          onChanged: (val) {
                            setState(() => name = val);
                          },
                          onSaved: (String? value) {
                            // This optional block of code can be used to run
                            // code when the user saves the form.
                          },
                          validator: (val) => val!.isEmpty ? 'Habit name is required' : null,
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      Container(
                        width: 300.0,
                        child: TextFormField(

                          cursorColor: Colors.green,
                          decoration: InputDecoration(
                              hintText: 'Habit unit',
                              icon: Icon(
                                Icons.linear_scale,
                                color: Colors.grey,

                              ),
                              contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: const BorderSide(color: Colors.lightGreen, width: 2.0),

                              )

                          ),
                          onChanged: (val) {
                            setState(() => unit = val);
                          },
                          onSaved: (String? value) {
                            // This optional block of code can be used to run
                            // code when the user saves the form.
                          },
                          validator: (val) => val!.isEmpty ? 'Unit is required' : null,
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      Row(
                        children:<Widget> [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 40.0),
                            child: IconButton(
                              icon: Icon(
                                  Icons.merge_type_sharp,
                                  color: Colors.grey,
                              ),
                              onPressed: (){

                              },
                            )
                          ),
                          Container(
                            width: 220.0,
                            child: DropdownButton<String>(
                              value: dropdownValue,
                              isExpanded: true,
                              icon: const Icon(Icons.arrow_downward),
                              elevation: 16,
                              style: const TextStyle(color: Colors.grey),

                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                              },
                              items: <String>['good', 'bad']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                      value,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 17.0
                                      ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height:10.0),
                      TextButton(
                          onPressed: (){
                            //validate and pop
                            validated();
                            Navigator.pop(context);
                          },
                          child: Container(
                              width: 300.0,
                              height: 50.0,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                color: kPrimaryColor,

                              ),
                              child: Text(
                                'Add habit to list',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0
                                ),
                              )
                          )
                      )

                    ],
                  )
              )
              ,


            ],
          ),
        ),
      ),
    );
  }
  String hashID()
  {
    //hash name and timestamp
    var timestamp = utf8.encode(DateTime.now().toString());
    var nameHash = utf8.encode(name);
    var digest = sha256.convert(nameHash + timestamp);
    // print("Digest as bytes: ${digest.bytes}");
    // print("Digest as hex string: $digest");
    // print(digest.toString());
    return digest.toString();
  }
  void _onFormSubmit()
  {
    //Box<Habit> habitBox = Hive.box<Habit>(HiveBoxes.habit);
    String habitId = hashID();
    widget.mainController.getHabitController!.addHabit(
        Habit(
            habitId: habitId,
            habitName: name,
            type: dropdownValue,
            unit: unit
        )
    );
  }
}
