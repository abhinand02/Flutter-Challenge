import 'dart:io';

class Area{
  double? result;
   void circle(){
    print('enter radius');
    int? r = int.parse(stdin.readLineSync()!);
    result =3.14*r*r;
    stdout.write('area of circle:');
    print(result);
   }
   void square(){
     print('enter the length');
    double? l = double.parse(stdin.readLineSync()!);
    result =l*l;
    stdout.write('Area of the Square is:');
    print(result);
   }
  void Rectangle(){
    print('Enter the length and width');
    double? l = double.parse(stdin.readLineSync()!);
    double? w = double.parse(stdin.readLineSync()!);
    result =l*w;
    stdout.write('Area of the rectangle is :');
    print(result);
  } 
  void Triangle(){
    print('Enter height and breadth');
    double? h = double.parse(stdin.readLineSync()!);
    double? b = double.parse(stdin.readLineSync()!);
    result = h*b;
    stdout.write('Area of the Triangle:');
    print(result);
  }
}

class Myclass extends Area{
  void calculate(){
    print('enter your choice');
    int? n = int.parse(stdin.readLineSync()!);
    switch(n){
     case 1 : circle();
     break;
     case 2: square();
     break;
     case 3: Rectangle();
     break;
     case 4: Triangle();
     break;
     default:print('enter a valid choice');
     break;
    }
  }
  
}



void main(List<String> args) {
  Myclass? my = Myclass();
  my.calculate();
}