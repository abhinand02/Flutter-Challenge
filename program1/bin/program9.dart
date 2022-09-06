import 'dart:io';

void main(List<String> args) {
  int row,col;
  for(row=1;row<=5;row++){
    for(col=1;col<=row;col++){
      stdout.write(' $col');
    }
    print('');
  }
}