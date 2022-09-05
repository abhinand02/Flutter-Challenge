import 'dart:io';

void main(List<String> args) {
  print('enter the marks scored by the student');
  stdout.write('Written test : ');
  double? wt = double.parse(stdin.readLineSync()!);
  stdout.write('Lab exams : ');
  double? lb = double.parse(stdin.readLineSync()!);
  stdout.write('Assignments : ');
  double? as = double.parse(stdin.readLineSync()!);
  double? total = ((wt*70)/100+(lb*20)/100+(as*10)/100);
  print(total);
}