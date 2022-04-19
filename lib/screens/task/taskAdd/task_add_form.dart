//Stateful widget that will work as a form
//Takes no parameter but after submitting the form
//It should be able to do a database query
import 'package:flutter/material.dart';
import 'package:habitrix/constants.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:habitrix/controllers/home_controller.dart';
import 'package:habitrix/models/task.dart';
import 'package:habitrix/screens/task/taskList/components/background.dart';
import 'package:intl/intl.dart';

class TaskAddForm extends StatefulWidget {
  TaskAddForm({required this.mainController});
  final HomeController mainController;
  @override
  _TaskAddFormState createState() => _TaskAddFormState();
}

class _TaskAddFormState extends State<TaskAddForm> {

  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  // text field state
  String name = '';
  DateTime ?deadline = null;
  double ?importance = 20;
  double ?difficulty = 20;
  validated() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _onFormSubmit();
      print("Form Validated");
      return true;
    } else {
      print("Form Not Validated");
      return false;
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
            'Add a new task',
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
                              hintText: 'Task name',
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
                          validator: (val) => val!.isEmpty ? 'Task name is required' : null,
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      Container(
                      width: 300.0,
                      child: TextFormField(
                        cursorColor: Colors.green,
                        decoration: InputDecoration(
                            hintText: deadline == null ? 'Deadline' : DateFormat('MM/dd kk:ss').format(deadline!),
                            icon: Icon(
                                Icons.calendar_today_outlined,
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

                        onTap: (){
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(2018,2,5),
                              onChanged: (date) {
                                print('change $date');
                              }, onConfirm: (date) {
                                setState(() {
                                  deadline = date;
                                  DatePicker.showTimePicker(context,
                                      showTitleActions: true,
                                      onChanged: (date) {
                                        print('change $date');
                                      }, onConfirm: (date) {
                                        setState(() {
                                          DateTime temp = date;
                                          deadline = DateTime(deadline!.year,deadline!.month,deadline!.day,date.hour,date.minute,date.second);
                                        });
                                        print('confirm $date');
                                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                                });
                                print('confirm $date');
                              }, currentTime: DateTime.now(), locale: LocaleType.en);
                          },
                          onSaved: (String? value) {
                            // This optional block of code can be used to run
                            // code when the user saves the form.
                          },
                          validator: (val) => deadline == null ? 'Deadline required' : null,
                        ),
                      ),
                      SizedBox(height:10.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 40.0),
                        child: Slider(
                          value: importance!,
                          activeColor: kPrimaryColor,
                          inactiveColor: Color(0xffd1dec9),
                          max: 100,
                          divisions: 10,
                          label:'Importance level ' + importance!.round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              importance = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(height:10.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 40.0),
                        child: Slider(
                          value: difficulty!,

                          activeColor: kPrimaryColor,
                          inactiveColor: Color(0xffd1dec9),
                          max: 100,
                          divisions: 10,
                          label:'Difficulty level ' + difficulty!.round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              difficulty = value;
                            });
                          },
                        ),
                      ),
                      TextButton(
                          onPressed: (){
                            //validate and pop
                            if(validated())Navigator.pop(context);
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
                                'Add New Task',
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
  void _onFormSubmit()
  {
    // Box<Task> taskBox = Hive.box<Task>(HiveBoxes.task);
    // taskBox.add(Task(taskName: name, deadline: deadline!, difficulty: difficulty!.round(), importance: importance!.round(), ));
    widget.mainController.getTaskController!.addTask(
        Task(
          taskName: name,
          deadline: deadline!,
          difficulty: difficulty!.round(),
          importance: importance!.round(),
        )
    );
  }
}

