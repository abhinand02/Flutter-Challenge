import 'dart:io';

void main(List<String> args) {
    print('enter principle amount');
    int? P  = int.parse(stdin.readLineSync()!);
    print('enter interest rate');
    double? R = double.parse(stdin.readLineSync()!);
    print('enter number of years');
    double? N = double.parse(stdin.readLineSync()!);
    double? SI =(P*R*N)/100;
    print('Simple interst is $SI');
}