import 'package:flutter/material.dart';
import 'package:login_and_home_page/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 212, 208, 208),
      appBar: AppBar(title:  const Text('Home'),backgroundColor:const Color.fromARGB(55, 98, 219, 198),actions:  [
        IconButton(
          icon: const Icon(Icons.logout_rounded),
          tooltip: 'Log Out',
          onPressed: (){
            clearData();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginPage()));
          }
        )
      ],),
      body: ListView.separated(itemBuilder: ( context,  index){
        if(index.isEven){
          return  ListTile(
            leading: const CircleAvatar(backgroundImage: AssetImage('images/pattiser.jpeg'),radius:30),
            subtitle: Text('List $index',style: const TextStyle(color: Colors.black,fontSize: 18),),
          );
        } 
        else{
          return  ListTile(
            leading: Image.asset('images/pattiser2.jpg'),
            subtitle: Text('List $index',style: const TextStyle(color: Colors.black,fontSize: 18),),
          );
        }
      }, separatorBuilder: ( context,  index){
        return const Divider(thickness: .4,);
      }, itemCount: 20,
      physics: const AlwaysScrollableScrollPhysics(),
      ),
    );
  }
}

Future<void> clearData() async{
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  sharedPref.remove('saved_data');
}

// class RoundedImg extends StatelessWidget {
//    RoundedImg({
//     Key? key,

//     required this.img,
//     required this.text,
//   }) : super(key: key);
  
//   String img;
//   String text;
  
//   @override
//   Widget build(BuildContext context) {
//     return Column( children:  [
//       Row(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: CircleAvatar(backgroundImage: AssetImage(img),radius: 40,)
//           ),
//           Text(text),
//         ],
//       ),
//       const Divider(),
//     ],);
//   }
// }

// class SquareImg extends StatelessWidget {
//    SquareImg({
//     Key? key,
//      required this.img,
//     required this.text,
//   }) : super(key: key);

//   String img;
//   String text;

//   @override
//   Widget build(BuildContext context) {
//     return Column( children:  [
//       Row(
//         children: const [
//           Padding(
//             padding:  EdgeInsets.all(10.0),
//             child: Image(image: AssetImage('images/img.png'),width: 100,)
//           ),
//           Text('abhinand'),
//         ],
//       ),
//       const Divider(),
//     ],);
//   }
// }


// ListView(
//         children: [
//             SquareImg(text: 'list 1',img: 'images/img.png'),
//             RoundedImg(text: 'list 2',img: 'images/img.png'),
//             SquareImg(text: 'list 1',img: 'images/img.png'),
//             RoundedImg(text: 'list 2',img: 'images/img.png'),
//             SquareImg(text: 'list 1',img: 'images/img.png'),
//             RoundedImg(text: 'list 2',img: 'images/img.png'),
//             SquareImg(text: 'list 1',img: 'images/img.png'),
//             RoundedImg(text: 'list 2',img: 'images/img.png'),
//             SquareImg(text: 'list 1',img: 'images/img.png'),
//             RoundedImg(text: 'list 2',img: 'images/img.png'),
//         ],
//       ),