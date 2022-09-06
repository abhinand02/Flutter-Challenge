import 'dart:io';

void main(List<String> args) {
  int i,c=0;
  print('enter a number');
  int? n = int.parse(stdin.readLineSync()!);
  for(i=2;i<n/2;i++){
    if(n%i==0){
      c=1;
      break;
    }
    else{
      continue;
    }
  }
  if(c==0){
    print('Entered number is a Prime number');
  }else{
    print('Entered number is not a Prime number');
  }
}