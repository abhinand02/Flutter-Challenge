import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:students_record/db/db.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

Future<void> addStudent(StudentModel value) async{
   final studentDb = await Hive.openBox<StudentModel>('student_db');
   final _id = await studentDb.add(value);
   value.id =_id;
   final id =value.id;
   studentDb.put(id,value);
   studentListNotifier.value.add(value);
   studentListNotifier.notifyListeners;
    getAllStudents();
  //  print(studentDb.values);
}

Future<void> getAllStudents()async {
  final studentDb = await Hive.openBox<StudentModel>('student_db');
  studentListNotifier.value.clear();


  studentListNotifier.value.addAll(studentDb.values);
  studentListNotifier.notifyListeners();
  
}

Future<void> deleteStudent(int id) async{
  final studentDb = await Hive.openBox<StudentModel>('student_db');
  studentDb.delete(id);
  getAllStudents();
}

Future<void> updateStudentDetails( StudentModel n,int id) async{
final studentDb = await Hive.openBox<StudentModel>('student_db');
await studentDb.put(id,n);
getAllStudents();
}