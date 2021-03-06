import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:habitrix/controllers/home_controller.dart';
import 'package:habitrix/models/habit.dart';
import 'package:habitrix/models/habit_entry.dart';
import 'package:habitrix/screens/habit/habitList/components/background.dart';
import 'package:intl/intl.dart';
import '../../../constants.dart';

class HabitEntryForm extends StatefulWidget {
  final Habit habit;
  final HomeController mainController;
  HabitEntryForm({required this.habit, required this.mainController});

  @override
  _HabitEntryFormState createState() => _HabitEntryFormState();
}

class _HabitEntryFormState extends State<HabitEntryForm> {
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  // text field state
  double? unitAmount=null;
  DateTime? entryDate = null;
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
            'Habit entry',
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
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.green,
                          decoration: InputDecoration(
                              hintText:  unitAmount == null ? widget.habit.habitName + ' ' + widget.habit.unit : unitAmount!.toString() + ' unit',
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
                            setState(() => unitAmount = double.parse(val));
                          },
                          onSaved: (String? value) {
                            // This optional block of code can be used to run
                            // code when the user saves the form.
                          },
                          validator: (val) => unitAmount == null ? 'Unit amount unspecified' : null,
                        ),
                      ),
                      SizedBox(height:10.0),
                      Container(
                        width: 300.0,
                        child: TextFormField(
                          cursorColor: Colors.green,
                          decoration: InputDecoration(
                              hintText: entryDate == null ? 'Date' : DateFormat('MM/dd').format(entryDate!),
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
                                maxTime: DateTime.now(),
                                onChanged: (date) {
                                  print('change $date');
                                }, onConfirm: (date) {
                                  setState(() {
                                    entryDate = date;
                                  });
                                  print('confirm $date');
                                }, currentTime: DateTime.now(), locale: LocaleType.en);
                          },
                          onSaved: (String? value) {
                            // This optional block of code can be used to run
                            // code when the user saves the form.
                          },
                          validator: (val) => entryDate == null? 'Must have entry date' : null,
                        ),
                      ),
                      SizedBox(height:10.0),
                      TextButton(
                          onPressed: (){
                            //validate and pop
                            if(validated())
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
                                'Save Changes',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0
                                ),
                              )
                          )
                      ),


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
    
    // Box<HabitEntry> habitEntryBox = Hive.box<HabitEntry>(HiveBoxes.habit_entry);
    // habitEntryBox.add(HabitEntry(habitId: widget.habit.habitId, entryAmount: unitAmount!, entryDate: entryDate!));
    widget.mainController.getHabitController!.addHabitEntry(
        HabitEntry(
            habitId: widget.habit.habitId,
            entryAmount: unitAmount!,
            entryDate: entryDate!
        )
    );
  }
}
