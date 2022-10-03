import 'dart:io';

void main(List<String> args) {
  print('enter 2 numbers');
  var a = int.parse(stdin.readLineSync()!);
  double? b = double.parse(stdin.readLineSync()!);
  double? sum = a + b;
  print('sum is $sum');
}