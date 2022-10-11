import 'package:flutter/material.dart';
import 'package:music_player/widgets/method.dart';
import '../constants/style.dart';
import 'home_screen.dart';

class RecentlyPlayedScreen extends StatelessWidget {
  const RecentlyPlayedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:
           ListView.builder(
            padding:  EdgeInsets.only(top: 10, bottom: playerVisibility ? 70 : 0),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Image(
                    image: AssetImage('assets/images/music-removebg.png')),
                title: Text(
                  'Strangers By Nature',
                  style: textWhite18,
                ),
                subtitle: Text(
                  'Adele',
                  style: TextStyle(color: unSelectedItemClr),
                ),
                trailing: favPlayListIcons(),
              );
            },
            itemCount: 10,
          ),
    );
  }
}