import 'dart:io';

void main(List<String> args) {
  print('enter your mark');
  double?  mark = double.parse(stdin.readLineSync()!);
    if(mark>=90){
            print("You scored A Grade");
        }
        else if(mark>=80 && mark<=89){
            print("You scored B Grade");
        }
        else if(mark >=70 && mark <=79){
            print("You scored C Grade");
        }
        else if(mark >= 60 && mark <=69){
            print("You Scored D Grade");
        }
        else if(mark >=50 && mark <=59){
            print("You Scored E Grade");
        }
        else{
            print("Failed");
        }
}