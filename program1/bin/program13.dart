import 'dart:io';

void main(List<String> args) {
  int i,c=0;
  print('enter a string');
  String? name = stdin.readLineSync()!;
  int? len=name.length;
  for(i=0;i<len;i++){
    if(name[i] == name[len-1-i]){
      continue;
    }
    else{
      c=1;
      break;
    }
  }
  if(c==0){
     print('Entered string is a palindrome');
}else{
  print('entered string is not a palindrome');
}
}
 