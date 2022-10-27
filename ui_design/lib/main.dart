import 'package:flutter/material.dart';
import 'package:ui_design/Screens/additional_info.dart';
import 'package:ui_design/Screens/catalouge.dart';
import 'package:ui_design/Screens/dukaan_premium.dart';
import 'package:ui_design/Screens/manage_store.dart';
import 'package:ui_design/Screens/order_detail.dart';
import 'package:ui_design/Screens/payments.dart';
// 
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
         debugShowCheckedModeBanner: false,
         home: DukaanPremiumPage(),
    );
  }
}