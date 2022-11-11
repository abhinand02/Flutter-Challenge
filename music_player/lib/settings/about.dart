import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});


  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(), child: const LicensePage(
          applicationName: 'Musik',
          applicationVersion: '1.0',
          applicationIcon:
               Image(image: AssetImage('assets/images/music.png'),),
              applicationLegalese: 'Developed By \nABHINAND MADHU',
            ));
  }
}