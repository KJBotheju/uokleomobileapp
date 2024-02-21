// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import './screens/SplashScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UOK LEO',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 250, 225, 2),
      ),
      home: SplashScreen(),
    );
  }
}
