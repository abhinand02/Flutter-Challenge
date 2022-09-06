import 'dart:io';

void main(List<String> args) {
  int i,j;
  List<int>? array = [];
  List<int>? array2=[];
  print('enter array size');
  int? n= int.parse(stdin.readLineSync()!);
  print('enter elements');
  for(i=0;i<n;i++){
     array.insert(i, int.parse(stdin.readLineSync()!));
  }
  for( i=0;i<n-1;i++){
      for( j=i+1;j<i+2;j++){
        array2.insert(i, array[i]*array[j]);
      }
    }
   print(array2.join(','));
}