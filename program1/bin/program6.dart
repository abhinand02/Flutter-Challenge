import 'dart:io';

void main(List<String> args) {
  print(
      'Select a Number \n 1: Sunday \n 2: Monday \n 3: Tuesday \n 4: Wednesday \n 5: Thursday \n 6: Friday \n 7: Saturday ');
  int? n = int.parse(stdin.readLineSync()!);
  switch (n) {
    case 1:
      print('You are selected sunday');
      break;
    case 2: print('you are selected monday');
    break;
    case 3: print('you are selected tuesday');
    break;
    case 4: print('you are selected wednesday');  
    break;
    case 5: print('you are selected thursday');
    break;
    case 6: print('you are selected friday');
    break;
    case 7: print('you are selected saturday');
    break;
    default: print('enter a valid number');
  }
}
