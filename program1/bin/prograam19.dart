import 'dart:io';

void main(List<String> args) {
   double total;
  print('enter your annual income');
  double? income =  double.parse(stdin.readLineSync()!);
  if(income<=250000){
            print('No Tax you have to pay');
        }else if(income > 250000 && income <= 500000){
            total = (income*5)/100;
           print(total);
        }else if(income > 500000 && income <= 1000000){
            total =  (income*20)/100;
            print(total);
        }else if(income > 1000000 && income <= 5000000){
            total =  (income*30)/100;
            print(total);
        }else{
 
        }
        
}