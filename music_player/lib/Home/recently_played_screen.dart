import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/Model/recentsong_model.dart';
import '../Model/db_functions.dart';
import '../constants/style.dart';
import 'home_screen.dart';

class RecentlyPlayedScreen extends StatelessWidget {
  const RecentlyPlayedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:ValueListenableBuilder<Box<RecentPlayed>>(valueListenable: recentlyplayedbox.listenable(),
       builder: (context, Box<RecentPlayed> recentsongs,_){
        List<RecentPlayed> rsongs = recentsongs.values.toList();
        return ListView.builder(
            padding:  EdgeInsets.only(top: 10, bottom: playerVisibility ? 70 : 0),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
                return recentsongs.isEmpty ?  Center(child:  Text('No Recent Played !', style: textWhite18,)):
                 ListTile(
                leading: const Image(
                    image: AssetImage('assets/images/music-removebg.png'),),
                title: Text(
                 rsongs[index].songname!,
                  style: textWhite18,
                ),
                subtitle: Text(
                  'Adele',
                  style: TextStyle(color: unSelectedItemClr),
                ),
                // trailing: favPlayListIcons(),
              );
              } ,             
            itemCount: rsongs.length,
          );
       }),
           
    );
  }
}