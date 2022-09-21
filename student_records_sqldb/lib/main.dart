import "package:flutter/material.dart";
import 'package:student_records_sqldb/db/functions/db_functions.dart';
import 'students_list_page.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await openDataBase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.cyan,scaffoldBackgroundColor: const Color.fromARGB(221, 238, 247, 250)),
        home: const StudentsRecord(),
        initialRoute: '/',
        routes: {
          'root': (context1)=> const  StudentsRecord(),
        },
    );
  }
}