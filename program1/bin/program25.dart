import 'dart:io';

void main(List<String> args) {
  print('enter a number');
  int? n = int.parse(stdin.readLineSync()!);
  bool? a =checkfunction(n);
  if(a==true){
    print('TRUE');
  }
  else{
    print('FALSE');
  }
}
bool checkfunction(int n){
   if(n%10==0){
    return true;
   }
   else{
    return false;
   }
  }