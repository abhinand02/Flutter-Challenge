import 'package:flutter/material.dart';
import '/home.dart';
import '/login.dart';
import 'splash.dart';

const SAVE_KEY_NAME = 'userlogedin';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'login sample',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ScreenSplash(),
      routes: {
        'homescreen': (context) => Screenhome(),
        'loginscreen': (context) => ScreenLogin()
      },
    );
  }
}

