import 'dart:io';

void main(List<String> args) {
  print('enter array size');
  List<int>? array = [];
  int? n = int.parse(stdin.readLineSync()!);
  getArray(array,n);
  displayArray(array);
}

void getArray(List array, int n) {
  int i;
  print('enter values');
  for(i=0;i<n;i++){
    array.insert(i, int.parse(stdin.readLineSync()!));
  }
}

void displayArray(List array) {
  print(array);
}
