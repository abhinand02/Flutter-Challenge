import 'dart:io';

void main(List<String> args) {
  double? f;
  stdout.write('Fahrenheit');
  stdout.write('\tCelsius\n');
  for(double i=0;i<160;i=i+10){
    stdout.write(f= (i * 9/5) + 32 );
    stdout.write('\t $i');
    print('');
  }
}