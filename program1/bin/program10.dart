import 'dart:io';

void main(List<String> args) {
  List? array1=[],array2=[];
  int i;
  print('enter the limit of the array');
  int? n= int.parse(stdin.readLineSync()!);
  print('enter first array elements');
  for(i=0;i<n;i++){
    array1.insert(i, int.parse(stdin.readLineSync()!));
  }
  print('enter second array elements');
  for(i=0;i<n;i++){
     array2.insert(i, int.parse(stdin.readLineSync()!));
  }

  for(i=0;i<n;i++){
    int temp= array1[i];
    array1[i]=array2[i];
    array2[i]=temp;
  }
  print('after swapping array1 is '+ array1.join(','));
  print('after swapping array2 is '+ array2.join(','));
  
}