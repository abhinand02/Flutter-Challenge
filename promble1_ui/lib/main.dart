import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:promble1_ui/Screens/booking_page.dart';
import 'package:promble1_ui/Screens/search_page.dart';
import 'Screens/splash.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: GoogleFonts.varelaRoundTextTheme(Theme.of(context).textTheme)),
      home: const SearchPage(),
    );
  }
}