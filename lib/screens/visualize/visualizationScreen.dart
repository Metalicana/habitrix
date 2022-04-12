import 'package:flutter/material.dart';
import 'package:habitrix/models/habit.dart';
import 'package:habitrix/models/habit_entry.dart';

import '../../constants.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class VisualizationScreen extends StatefulWidget {
  Habit? habit;
  late HabitEntry entry;
  late List<double> datum;
  late List<_HabitData> dataMera;
  VisualizationScreen(Habit habit)
  {
    this.habit = habit;
    entry = new HabitEntry(habitId: habit.habitId, entryDate: DateTime.now(), entryAmount: 0);
    //Query this entry to get all the necessary lists.
    //Map the lists with integer numbers
    datum = entry.dailyHabitEntries();
    dataMera = sendList(datum);
    //print('Length: '  + dataMera.length.toString());

  }
  List<_HabitData> sendList(List<double> input)
  {
    List<_HabitData> ok = List<_HabitData>.generate(input.length, (index) => _HabitData(idx: index+1, amount: input[index]));
    for(int i=0;i<input.length;i++)
    {
      print(ok.elementAt(i).amount);
    }
    return ok;
  }

  @override
  _VisualizationScreenState createState() => _VisualizationScreenState();
}

class _VisualizationScreenState extends State<VisualizationScreen> {



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // List<_HabitData> data = [
    //   _HabitData(idx: 1, amount:10),
    //   _HabitData(idx: 2, amount:16),
    //   _HabitData(idx: 3, amount:20),
    //   _HabitData(idx: 4, amount:40),
    //   _HabitData(idx: 0, amount:5),
    // ];
    List<_HabitData> data = widget.dataMera;
    return Scaffold(
        backgroundColor: Color(0xFFf4f7f2),
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(50.0),
            ),
          ),
          title: const Text('Habits',
              style: TextStyle(
                fontSize: 30.0,
              )),
          toolbarHeight: 220,
          backgroundColor: kPrimaryColor,
        ),
        body: Column(

            children: <Widget>[
          //Initialize the chart widget
              SizedBox(height: 25.0,),
              SfCartesianChart(

                  primaryXAxis: NumericAxis(
                      visibleMaximum: 15,
                      visibleMinimum: 1,
                      interval: 1
                  ),

                  // Chart title
                  title: ChartTitle(text: widget.habit!.habitName + ' analysis'),
                  // Enable legend
                  legend: Legend(isVisible: true),
                  zoomPanBehavior: ZoomPanBehavior(
                    enablePanning: true,
                  ),
                  // Enable tooltip
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <ChartSeries<_HabitData, int>>[
                    LineSeries<_HabitData, int>(
                        dataSource: data,
                        xValueMapper: (_HabitData habitat, _) => habitat.idx,
                        yValueMapper: (_HabitData habitat, _) => habitat.amount,
                        name: widget.habit?.habitName,
                        color: kPrimaryColor,
                        // Enable data label
                        dataLabelSettings: DataLabelSettings(isVisible: true))
                  ]),
        ]));
    // return Scaffold(
    //   appBar: AppBar(
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.vertical(
    //         bottom: Radius.circular(50.0),
    //       ),
    //     ),
    //     title: const Text('Statistics',
    //         style: TextStyle(
    //           fontSize: 30.0,
    //         )),
    //     toolbarHeight: 220,
    //     backgroundColor: kPrimaryColor,
    //   ),
    //   body: Container(
    //     child: SingleChildScrollView(
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: <Widget>[
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.start,
    //             children: <Widget>[
    //               SizedBox(
    //                 width: 30.0,
    //                 height: 10.0,
    //               ),
    //               InputChip(
    //                 selectedColor: Colors.green[800],
    //                 disabledColor: kPrimaryColor,
    //                 backgroundColor: kPrimaryColor,
    //                 label: Text(
    //                   'Day',
    //                   style: TextStyle(
    //                     color: Colors.white,
    //                   ),
    //                 ),
    //                 onSelected: (bool value) {},
    //               ),
    //               SizedBox(
    //                 width: 15.0,
    //                 height: 10.0,
    //               ),
    //               InputChip(
    //                 selectedColor: Colors.green[800],
    //                 disabledColor: kPrimaryColor,
    //                 backgroundColor: kPrimaryColor,
    //                 label: Text(
    //                   'Week',
    //                   style: TextStyle(
    //                     color: Colors.white,
    //                   ),
    //                 ),
    //                 onSelected: (bool value) {},
    //               ),
    //               SizedBox(
    //                 width: 15.0,
    //                 height: 10.0,
    //               ),
    //               InputChip(
    //                 selectedColor: Colors.green[800],
    //                 disabledColor: kPrimaryColor,
    //                 backgroundColor: kPrimaryColor,
    //                 label: Text(
    //                   'Month',
    //                   style: TextStyle(
    //                     color: Colors.white,
    //                   ),
    //                 ),
    //                 onSelected: (bool value) {},
    //               ),
    //               SizedBox(
    //                 width: 15.0,
    //                 height: 10.0,
    //               ),
    //
    //             ],
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }

}
class _HabitData {
  _HabitData({required this.idx, required this.amount});

  int idx;
  double amount;
  void setIdx(int idx)
  {
    this.idx = idx;
  }
  void setAmount(double amount)
  {
    this.amount = amount;
  }

}
