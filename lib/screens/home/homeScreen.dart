import 'package:flutter/material.dart';
import 'package:habitrix/constants.dart';
import 'package:habitrix/screens/home/components/body.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 200,
          backgroundColor: kPrimaryColor,
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary),
              onPressed: () {},
              child: const Text('Action 1'),
            ),
            TextButton(
              style: TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary),
              onPressed: () {},
              child: const Text('Action 2'),
            )
          ],
      ),
      body: Body(),
    );
  }
}
