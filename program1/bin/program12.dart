import 'dart:io';

void main(List<String> args) {
  List<int>? array1=[];
  int i,j;
  print('enter the limit');
  int? n = int.parse(stdin.readLineSync()!);
  print('enter the values');
  for(i=0;i<n;i++){
    array1.insert(i, int.parse(stdin.readLineSync()!));
  }
  print('sorted array :');
  for(i=0;i<n-1;i++){
    for(j=i+1;j<n;j++){
         if (array1[i] < array1[j]) {
       int? tem = array1[i];
       array1[i]= array1[j];
       array1[j]=tem;
    }
    }
 
  }
  print(array1);
}