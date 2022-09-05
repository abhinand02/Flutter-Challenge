import 'dart:io';

void main(List<String> args) {
  int i;
  print('enter a number');
  int? a = int.parse(stdin.readLineSync()!);
  for( i=1;i<11;i++){
     print('$i x $a = ${i*a}');
  }
}