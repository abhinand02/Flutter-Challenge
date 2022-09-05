import 'dart:io';

void main(List<String> args) {
  int i,sum=0;
  print('enter a number');  int? a = int.parse(stdin.readLineSync()!);
  for(i=1;i<a;i++){
    if(i%2!=0){
      sum+=i;
    }
  }
  print('sum of odd numbers from the given limit $sum');
}