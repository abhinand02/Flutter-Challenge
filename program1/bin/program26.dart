import 'dart:io';

void main(List<String> args) {
  int i,status=0;
  var w='';
  print('enter a string');
  String? s = stdin.readLineSync()!;
  int? len = s.length;
  for(i=0;i<len;i++){
    if(s[i]==' '){
   print(s.replaceAll('  ', ''));
    }
  }
}