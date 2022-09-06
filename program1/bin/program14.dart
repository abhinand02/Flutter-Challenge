import 'dart:io';

void main(List<String> args) {
  int a,b;
  List value=[1,2,3,];
  print('enter array size');
  int? n = int.parse(stdin.readLineSync()!);
  var list = List.generate(n,(i) => List.generate(n, (j) => value));
  // print('enter values');
  // for(a=0;a<n;a++){
  //   for(b=0;b<n;b++){
  //     value = int.parse(stdin.readLineSync()!);
  //   }
  // }
   print(list);
}