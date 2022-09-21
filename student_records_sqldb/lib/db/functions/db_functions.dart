import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import '../db.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);
late Database _db;
Future<void> openDataBase() async{
  _db= await openDatabase('studentDb.db',version: 1,onCreate:  (db, version) async{
  await db.execute('CREATE TABLE student_table(id INTEGER PRIMARY KEY, name TEXT, age TEXT, number TEXT, standard TEXT)');
  });
}

Future<void> addStudent(StudentModel value) async{
 await _db.rawInsert('INSERT INTO student_table(name,age,number,standard) VALUES (?,?,?,?)',[value.name,value.age,value.phnnumber,value.standard]);
 getAllStudents();
  //  studentListNotifier.value.add(value);
  //  studentListNotifier.notifyListeners;
  //  print(studentDb.values);
}

Future<void> getAllStudents()async {
 final values = _db.rawQuery('SELECT * FROM student_table');
  print(values);
  studentListNotifier.value.clear();
  
  values.forEach((map){
    
  })
  
}

Future<void> deleteStudent(int id) async{
 
  getAllStudents();
}

Future<void> updateStudentDetails( StudentModel n,int id) async{

getAllStudents();
}