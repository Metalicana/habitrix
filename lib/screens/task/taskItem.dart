import 'package:flutter/material.dart';
import 'package:habitrix/constants.dart';
import 'package:habitrix/models/task.dart';
import 'package:intl/intl.dart';

class TaskItem extends StatefulWidget {
  final Task task;
  bool checked = false;
  TaskItem({Key? key,  required this.task}) : super(key: key);

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
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
                widget.checked ? Icons.check_box_outlined: Icons.check_box_outline_blank_rounded,
                color: kPrimaryColor,
            )

          ),
          title: Text(widget.task.taskName),
          subtitle: Text(DateFormat('MM/dd  kk:mm').format(widget.task.deadline)),
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
