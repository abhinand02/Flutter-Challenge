import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
part 'db.g.dart';

@HiveType(typeId: 1)
class StudentModel{

  @HiveField(0)
  final String name;

  @HiveField(1)
  final String age;

  @HiveField(2)
  final String phnnumber;

  @HiveField(3)
  final String standard;

  @HiveField(4)
   int? id;

   @HiveField(5)
   final Uint8List? image;

  StudentModel( {this.image, required this.name, required this.age, required this.phnnumber, required this.standard,this.id});
}