import 'package:flutter/material.dart';
import 'package:music_player/constants/style.dart';
import 'package:music_player/widgets/method.dart';

class SettingsScreen extends StatelessWidget {
   const SettingsScreen({super.key});

 final _icons = const [
  Icons.share_outlined,
  Icons.notifications_active_outlined,
  Icons.privacy_tip_outlined,    //DRMN149
  Icons.description_outlined,
  Icons.info_outline
 ];

 final _titles = const [
    'Share this App',
    'Notifications',
    'Privacy Policy',
    'Terms & Conditions',
    'About',
 ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Settings'),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(itemBuilder: (context,index){
              return ListTile(leading: Icon(_icons[index],color: whiteClr,size: 25,),title: Text(_titles[index],style: textWhite18,),);
            },
            itemCount: 5,
            ),
          )
        ],
      ),
    );
  }
}