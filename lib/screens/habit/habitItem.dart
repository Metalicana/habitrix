import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitrix/constants.dart';
import 'package:habitrix/models/habit.dart';
import 'package:habitrix/models/task.dart';
import 'package:habitrix/screens/visualize/visualizationScreen.dart';
import 'package:intl/intl.dart';
import 'package:expansion_card/expansion_card.dart';

import 'habitEdit/habitEditForm.dart';
import 'habitEntry/habitEntryForm.dart';

class HabitItem extends StatefulWidget {
  final Habit habit;
  bool checked = false;
  HabitItem({Key? key,  required this.habit}) : super(key: key);

  @override
  _HabitItemState createState() => _HabitItemState();
}

class _HabitItemState extends State<HabitItem> {
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: GestureDetector(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  HabitEditForm(habit: widget.habit)),
          );
        },
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(25.0),
                top : Radius.circular(25.0)
            ),
          ),
          child: ListTile(
            leading: IconButton(
                onPressed: (){
                  setState(() {
                    widget.checked = !widget.checked;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  VisualizationScreen(habit: widget.habit)),
                    );
                  });

                },
                icon: Icon(
                  widget.checked ? Icons.bar_chart  : Icons.bar_chart_outlined,
                  color: kPrimaryColor,
                )

            ),
            title: Text(widget.habit.habitName),
            subtitle: Text(
              'Habit type: ' + widget.habit.type + ' Unit: ' + widget.habit.unit
            ),
            trailing : IconButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  HabitEntryForm(habit: widget.habit)),
                    );
                  },
                  icon: Icon(Icons.add)
                ),
            // trailing: Row(
            //   children: <Widget>[
            //     IconButton(
            //       onPressed: (){},
            //       icon: Icon(Icons.add)
            //     ),
            //     SizedBox(width: 10.0,),
            //     IconButton(
            //         onPressed: (){},
            //         icon: Icon(Icons.add)
            //     ),
            //   ],
            // ),
          ),
        ),
      ),
    );
  }
}



// class _HabitItemState extends State<HabitItem> {
//   @override
//   Widget build(BuildContext context) {
//
//     return Padding(
//       padding: const EdgeInsets.only(top: 8.0),
//       child: Card(
//         margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(
//               bottom: Radius.circular(25.0),
//               top : Radius.circular(25.0)
//           ),
//         ),
//         child: ExpansionCard(
//           title: Container(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Text(
//                   widget.habit.habitName,
//                   style: TextStyle(
//                     fontSize: 25,
//                     color: Colors.black,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           children: <Widget>[
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 10),
//               child: Text("Content goes over here !",
//                   style: TextStyle(
//                       fontFamily: 'BalooBhai',
//                       fontSize: 15,
//                       color: Colors.black)),
//             )
//           ],
//         )
//       ),
//     );
//   }
// }
