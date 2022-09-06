import 'dart:io';

void main(List<String> arguments) {
  print('Enter a Character');
  var name = stdin.readLineSync();
  print("you entered character is $name");
}
