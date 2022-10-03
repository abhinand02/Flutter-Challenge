import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:promble1_ui/Screens/booking_page.dart';
import 'package:promble1_ui/constants/style.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      width: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Color.fromARGB(255, 22, 32, 31),
            Color.fromARGB(255, 28, 44, 43),
          ])),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20, left: 20, top: 40),
              child: Text('Find And Book \n A Great Expirence',
                  style: headingStyle),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 40),
              child: Text(
                  'Going  forward after a pandemic that  \ndevastated the airlline industry.',
                  style: smalltext),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                   return const BookingScreen();
                  }));
                },
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Get Tickets',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
            Expanded(
                child: Image.asset(
              'assets/images/image1.png',
              fit: BoxFit.cover,
            )),
          ],
        ),
      ),
    ));
  }
}
