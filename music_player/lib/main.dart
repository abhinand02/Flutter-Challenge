import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/constants/style.dart';
import 'Splash Screen/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: GoogleFonts.urbanistTextTheme(Theme.of(context).textTheme,),
        appBarTheme: AppBarTheme(backgroundColor: backGroundColor),
        sliderTheme: const SliderThemeData(trackHeight: 2),
      scaffoldBackgroundColor: backGroundColor),
      home: const SplashScreen(
      ),
    );
  }
}