import 'package:flutter/material.dart';
import 'package:habitrix/constants.dart';
import 'package:habitrix/models/habit.dart';
import 'package:habitrix/models/task.dart';
import 'package:intl/intl.dart';

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
                });
              },
              icon: Icon(
                widget.checked ? Icons.bar_chart  : Icons.bar_chart_outlined,
                color: kPrimaryColor,
              )

          ),
          trailing: IconButton(
              onPressed: ()
              {

              },
              icon: Icon(
                widget.checked ? Icons.add  : Icons.add_box_rounded,
                color: kPrimaryColor,
              )
          ),
          title: Text(widget.habit.habitName),
          subtitle: Text(
            'Habit type: ' + widget.habit.type + ' Unit: ' + widget.habit.unit
          ),
        ),
      ),
    );
  }
}

// class TaskItem extends StatelessWidget {
//   final Task task;
//   TaskItem({ required this.task });
//
//   @override
//   Widget build(BuildContext context) {
//     bool checked = false;
//     return Padding(
//       padding: const EdgeInsets.only(top: 8.0),
//       child: Card(
//         margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
//         child: ListTile(
//           leading: IconButton(
//             onPressed: (){
//
//             },
//             icon: Icon(
//                 Icons.check_box_outline_blank_rounded,
//                 color: kPrimaryColor,
//             )
//
//           ),
//           title: Text(task.taskName),
//           subtitle: Text(DateFormat('MM/dd  kk:mm').format(task.deadline)),
//         ),
//       ),
//     );
//   }
// }
