import 'dart:io';

void main(List<String> args) {
  print('enter your mark');
  double? mark = double.parse(stdin.readLineSync()!);
  if(mark >=50 && mark <=100 )
  {
    print('Passed');
  }else if(mark >100){
    print('Enter a valid mark');
  }
  else{
    print('Failed');
  }
}