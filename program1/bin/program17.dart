import 'dart:io';

class Operations{
  void addition(double num1, num2){
    stdout.write('result is: ');
    print(num1+num2);
  }

  void subtraction(double num1,num2){
    stdout.write('result is: ');
    print(num1-num2);
  }

  void multiplication(double num1, num2){
       stdout.write('result is: ');
    print(num1*num2);
  }

  void division(double num1, num2){
       stdout.write('result is: ');
    print(num1/num2);
  }
}

void main(List<String> args) {
    Operations op = Operations();
    print('enter 2 numbers');
    double? num1 = double.parse(stdin.readLineSync()!);
    double? num2 = double.parse(stdin.readLineSync()!);
    print('choose operator');
    print('1: Addition \n 2: Subtraction \n 3: Multiplication \n 4: Division');
    int? n = int.parse(stdin.readLineSync()!);
    switch(n){
      case 1: op.addition(num1, num2);
      break;
      case 2: op.subtraction(num1, num2);
      break;
      case 3: op.multiplication(num1, num2);
      break;
      case 4: op.division(num1, num2);
      break;
      default: print('enter a valid choice');
    } 
  }