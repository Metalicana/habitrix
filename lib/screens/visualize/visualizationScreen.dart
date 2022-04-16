import 'dart:math';

import 'package:flutter/material.dart';
import 'package:habitrix/controllers/home_controller.dart';
import 'package:habitrix/models/habit.dart';
import 'package:habitrix/models/habit_entry.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class VisualizationScreen extends StatefulWidget {
  Habit? habit;
  late final HomeController mainController;
  late HabitEntry entry;
  late List<double> dayData;
  late List<_HabitEntry> dayDataDetail;

  late List<double> weekData;
  late List<_HabitEntry> weekDataDetail;

  late List<double> monthData;
  late List<_HabitEntry> monthDataDetail;

  late DateTime? startingDay;
  late double minVal;
  late double maxVal;
  late double diff;
  VisualizationScreen(Habit habit, HomeController mainController)
  {
    this.mainController = mainController;
    this.habit = habit;
    entry = new HabitEntry(habitId: habit.habitId, entryDate: DateTime.now(), entryAmount: 0);
    //Query this entry to get all the necessary lists.
    //Map the lists with integer numbers
    startingDay = mainController.getHabitController!.firstEntryDate(habit);
    //startingDay = entry.firstEntryDate();
    dayData = mainController.getHabitController!.dailyHabitEntries(habit);
    //dayData = entry.dailyHabitEntries();
    weekData = mainController.getHabitController!.weeklyHabitEntries(habit);
    //weekData = entry.weeklyHabitEntries();
    monthData = mainController.getHabitController!.monthlyHabitEntries(habit);
    //monthData = entry.monthlyHabitEntries();
    dayDataDetail = dayEntryList(dayData);
    weekDataDetail = weekEntryList(weekData);
    monthDataDetail = monthEntryList(monthData);

    //weekDataDetail =
    minVal = -1.0;
    maxVal = -1.0;
    for(int i=0;i<dayData.length;i++){
      double val = dayData.elementAt(i);
      if(i ==0){
        minVal = val;
        maxVal = val;
      }
      else{
        if(val < minVal)minVal = val;
        if(val > maxVal)maxVal =val;
      }
    }
    print(maxVal.toString() + '  ' + minVal.toString());
    diff = (maxVal-minVal)/20.0 ;
    //print('Length: '  + dataMera.length.toString());

  }
  List<_HabitEntry> dayEntryList(List<double> input)
  {
    List<_HabitEntry> ok = List<_HabitEntry>.generate(input.length, (index) => _HabitEntry(
        date: DateTime(startingDay!.year, startingDay!.month, startingDay!.day).add(Duration(days: index)),
        amount: input[index]
      )
    );
    return ok;
  }
  List<_HabitEntry> weekEntryList(List<double> input)
  {
    List<_HabitEntry> ok = List<_HabitEntry>.generate(input.length, (index) => _HabitEntry(
        date: DateTime(startingDay!.year, startingDay!.month, startingDay!.day).add(Duration(days: (7*(index)))),
        amount: input[index]
    )
    );
    return ok;
  }
  List<_HabitEntry> monthEntryList(List<double> input)
  {
    List<_HabitEntry> ok = List<_HabitEntry>.generate(input.length, (index) => _HabitEntry(
        date: DateTime(startingDay!.year, startingDay!.month, startingDay!.day).add(Duration(days: (30*(index)))),
        amount: input[index]
    )
    );
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
    List<_HabitEntry> dayDataFinal = widget.dayDataDetail;
    List<_HabitEntry> weekDataFinal = widget.weekDataDetail;
    List<_HabitEntry> monthDataFinal = widget.monthDataDetail;
    // for(int i=0;i<weekDataFinal.length;i++)
    //   {
    //     print(weekDataFinal.elementAt(i).amount);
    //   }
    // print(dayDataFinal.length);
    // print(weekDataFinal.length);
    // print(monthDataFinal.length);

    return Scaffold(
        backgroundColor: Color(0xFFf4f7f2),
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(50.0),
            ),
          ),
          title: const Text('Habit analysis',
              style: TextStyle(
                fontSize: 30.0,
              )),
          toolbarHeight: 220,
          backgroundColor: kPrimaryColor,
        ),
        body: ListView(

            children: <Widget>[

          //Initialize the chart widget
              SizedBox(height: 25.0,),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: SfCartesianChart(
                    primaryXAxis: DateTimeAxis(
                        interval: 1,
                        minorTicksPerInterval: 1,
                        intervalType: DateTimeIntervalType.days,
                        autoScrollingDelta: 10,
                        autoScrollingMode: AutoScrollingMode.start,
                        majorGridLines: MajorGridLines(
                          width: 0.0
                        )
                    ),
                    primaryYAxis: NumericAxis(
                        interval: max(5,min(widget.diff , 20.0)) ,
                        majorGridLines: MajorGridLines(
                          width: 0.0
                        )
                    ),
                    // Chart title
                    title: ChartTitle(text: widget.habit!.habitName + ' daily analysis'),
                    // Enable legend
                    legend: Legend(isVisible: true),
                    zoomPanBehavior: ZoomPanBehavior(
                      enablePanning: true,
                    ),
                    // Enable tooltip
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <ChartSeries<_HabitEntry, DateTime>>[
                      LineSeries<_HabitEntry, DateTime>(
                          dataSource: dayDataFinal,
                          xValueMapper: (_HabitEntry habitat, _) => habitat.date,
                          yValueMapper: (_HabitEntry habitat, _) => habitat.amount,
                          name: widget.habit?.habitName,
                          color: kPrimaryColor,
                          // Enable data label
                          dataLabelSettings: DataLabelSettings(isVisible: false))
                    ]),
              ),
              SizedBox(height: 25.0,),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: SfCartesianChart(
                    primaryXAxis: DateTimeAxis(
                        interval: 1,
                        intervalType: DateTimeIntervalType.days,
                        minorTicksPerInterval: 7,
                        autoScrollingDelta: 10,
                        autoScrollingMode: AutoScrollingMode.start,
                        majorGridLines: MajorGridLines(
                            width: 0.0
                        )
                    ),
                    primaryYAxis: NumericAxis(
                        interval: max(5,min(widget.diff , 20.0)) ,
                        majorGridLines: MajorGridLines(
                            width: 0.0
                        )
                    ),
                    // Chart title
                    title: ChartTitle(text: widget.habit!.habitName + ' weekly analysis'),
                    // Enable legend
                    legend: Legend(isVisible: true),
                    zoomPanBehavior: ZoomPanBehavior(
                      enablePanning: true,
                    ),
                    // Enable tooltip
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <ChartSeries<_HabitEntry, DateTime>>[
                      LineSeries<_HabitEntry, DateTime>(
                          dataSource: weekDataFinal,
                          xValueMapper: (_HabitEntry habitat, _) => habitat.date,
                          yValueMapper: (_HabitEntry habitat, _) => habitat.amount,
                          name: widget.habit?.habitName,
                          color: kPrimaryColor,
                          // Enable data label
                          dataLabelSettings: DataLabelSettings(isVisible: false))
                    ]),
              ),
              SizedBox(height: 25.0,),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: SfCartesianChart(
                    primaryXAxis: DateTimeAxis(
                        interval: 1,
                        autoScrollingDelta: 10,
                        intervalType: DateTimeIntervalType.months,
                        minorTicksPerInterval: 1,
                        autoScrollingMode: AutoScrollingMode.start,
                        majorGridLines: MajorGridLines(
                            width: 0.0
                        )
                    ),
                    primaryYAxis: NumericAxis(
                        interval: max(5,min(widget.diff , 20.0)) ,
                        majorGridLines: MajorGridLines(
                            width: 0.0
                        )
                    ),
                    // Chart title
                    title: ChartTitle(text: widget.habit!.habitName + ' monthly analysis'),
                    // Enable legend
                    legend: Legend(isVisible: true),
                    zoomPanBehavior: ZoomPanBehavior(
                      enablePanning: true,
                    ),
                    // Enable tooltip
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <ChartSeries<_HabitEntry, DateTime>>[
                      LineSeries<_HabitEntry, DateTime>(
                          dataSource: monthDataFinal,
                          xValueMapper: (_HabitEntry habitat, _) => habitat.date,
                          yValueMapper: (_HabitEntry habitat, _) => habitat.amount,
                          name: widget.habit?.habitName,
                          color: kPrimaryColor,
                          // Enable data label
                          dataLabelSettings: DataLabelSettings(isVisible: false))
                    ]),
              ),
          ]
        )
    );
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
class _HabitEntry{
  _HabitEntry({required this.date, required this.amount});
  DateTime date;
  double amount;
}

