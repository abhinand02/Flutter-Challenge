import 'package:flutter/material.dart';
import 'package:music_player/constants/style.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: blackClr,
      body:  const LicensePage(
        applicationName: 'Musik',
        applicationVersion: '1.0',
        applicationIcon:
             Image(image: AssetImage('assets/images/music.png'),),
            applicationLegalese: 'Developed By \nABHINAND MADHU',
          ),
    );
  }
}