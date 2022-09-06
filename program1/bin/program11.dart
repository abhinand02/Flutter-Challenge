import 'dart:io';

void main(List<String> args) {
  List<int>? array1=[];
  int i,c=0;
  print('enter the size of an array');
  int? a = int.parse(stdin.readLineSync()!);
  print('enter the values of array');
  for(i=0;i<a;i++){
   array1.insert(i, int.parse(stdin.readLineSync()!));
  }
  for(var e in array1){
    if(e%2==0){
      c++;
    }
  }

   print('total number of even number is $c');
}