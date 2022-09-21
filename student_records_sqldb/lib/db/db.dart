import 'dart:typed_data';

class StudentModel{

  final String name;

  final String age;

  final String phnnumber;

  final String standard;

   int? id;

   final Uint8List? image;

  StudentModel( {this.image, required this.name, required this.age, required this.phnnumber, required this.standard,this.id});

  static StudentModel fromMap(Map<String, Object?> map){
    final id = map['id'] as int ;
    final name = map['name'] as String;
    final age = map['age'] as String;
    final division = map['standard'] as String;
    final mnumber = map['number'] as String;

    return StudentModel(name: name, age: age, phnnumber: mnumber, standard: division);
  }
}