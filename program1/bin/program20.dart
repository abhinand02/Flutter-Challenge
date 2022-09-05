import 'dart:io';

void main(List<String> args) {
  int i,j,c=1;
  print('enter a number');
  int?  a= int.parse(stdin.readLineSync()!); 
  for(i=1;i<=a;i++){
    for(j=1;j<i;j++){
      stdout.write(' $c');
      c++;
    }
    print('');
  }
}