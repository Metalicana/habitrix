//Stateful widget that will work as a form
//Takes no parameter but after submitting the form
//It should be able to do a database query
import 'package:flutter/material.dart';
import 'package:habitrix/constants.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:habitrix/screens/task/taskList/components/background.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

class HabitEditForm extends StatefulWidget {
  const HabitEditForm({Key? key}) : super(key: key);

  @override
  _HabitEditFormState createState() => _HabitEditFormState();
}

class _HabitEditFormState extends State<HabitEditForm> {

  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  // text field state
  String email = '';
  String password = '';
  DateTime ?deadline = null;
  double importance = 20;
  double difficulty = 20;
  String dropdownValue = 'good';
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
            'Edit habit',
            style: TextStyle(
              fontSize: 30.0,
            )
        ),
        toolbarHeight: 220,
        backgroundColor: kPrimaryColor,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'logout',
            onPressed: ()  {

            },
          ),
        ],
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
                            setState(() => email = val);
                          },
                          onSaved: (String? value) {
                            // This optional block of code can be used to run
                            // code when the user saves the form.
                          },
                          validator: (val) => val!.isEmpty ? 'Task name is required' : null,
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
                            setState(() => email = val);
                          },
                          onSaved: (String? value) {
                            // This optional block of code can be used to run
                            // code when the user saves the form.
                          },
                          validator: (val) => val!.isEmpty ? 'Task name is required' : null,
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
}

// class TaskAddForm extends StatefulWidget {
//   const TaskAddForm({Key? key}) : super(key: key);
//
//   @override
//   _TaskAddFormState createState() => _TaskAddFormState();
// }
//
// class _TaskAddFormState extends State<TaskAddForm> {
//   @override
//   Widget build(BuildContext context) {
//
//     final _formKey = GlobalKey<FormState>();
//
//     String error = '';
//
//     bool loading = false;
//
//     // text field state
//     String email = '';
//
//     String password = '';
//
//     DateTime deadline = DateTime.now();
//     return Scaffold(
//       appBar: AppBar(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(
//             bottom: Radius.circular(50.0),
//           ),
//         ),
//         title: const Text(
//             'Add a new task',
//             style: TextStyle(
//               fontSize: 30.0,
//             )
//         ),
//         toolbarHeight: 220,
//         backgroundColor: kPrimaryColor,
//         actions: <Widget>[
//           IconButton(
//             icon: const Icon(Icons.logout),
//             tooltip: 'logout',
//             onPressed: ()  {
//
//             },
//           ),
//         ],
//       ),
//       body: Form(
//             key: _formKey,
//             child: Column(
//               children: <Widget>[
//                 SizedBox(height: 100.0),
//                 Container(
//                   padding: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
//                   width: 400.0,
//                   child: TextFormField(
//                         cursorColor: Colors.green,
//                         decoration: InputDecoration(
//                         hintText: 'Task Name',
//                         icon: Icon(Icons.drive_file_rename_outline),
//                         contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(30.0),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(30.0),
//                           borderSide: const BorderSide(color: Colors.lightGreen, width: 2.0),
//                         )
//                     ),
//                     onChanged: (val) {
//                       setState(() => email = val);
//                     },
//                     onSaved: (String? value) {
//                       // This optional block of code can be used to run
//                       // code when the user saves the form.
//                     },
//                     validator: (val) => val!.isEmpty ? 'Enter non-empty task name' : null,
//                   ),
//                 ),
//                 SizedBox(height: 10.0),
//                 Container(
//                   padding: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
//                   width: 400.0,
//                   child: TextFormField(
//                     cursorColor: Colors.green,
//                     decoration: InputDecoration(
//                         hintText: 'Deadline',
//                         icon: Icon(Icons.calendar_today_outlined),
//                         contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(30.0),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(30.0),
//                           borderSide: const BorderSide(color: Colors.lightGreen, width: 2.0),
//                         )
//                     ),
//
//                     onTap: (){
//                       DatePicker.showDatePicker(context,
//                           showTitleActions: true,
//                           minTime: DateTime(2018,2,5),
//                           onChanged: (date) {
//                             print('change $date');
//                           }, onConfirm: (date) {
//                             print('confirm $date');
//                           }, currentTime: DateTime.now(), locale: LocaleType.en);
//                     },
//                     onSaved: (String? value) {
//                       // This optional block of code can be used to run
//                       // code when the user saves the form.
//                     },
//                     validator: (val) => val!.isEmpty ? 'Enter non-empty task name' : null,
//                   ),
//                 ),
//               ],
//             )
//         ),
//
//     );
//   }
// }
