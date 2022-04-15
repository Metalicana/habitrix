import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:habitrix/constants.dart';
class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green[50],
      child: Center(
        child: SpinKitChasingDots(
          color: kPrimaryColor,
          size: 50.0,
        ),
      ),
    );
  }
}
