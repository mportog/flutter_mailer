import 'package:flutter/material.dart';

import 'constants/constants.dart';
import 'screens/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Quick Emailer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Const.primarySwatch,
      ),
      home: Login(),
    );
  }
}
