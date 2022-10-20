import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/Model/recentsong_model.dart';
import 'package:on_audio_query/on_audio_query.dart';
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

        if(rsongs.isEmpty){
          return Center(child: Text('No Recently played', style: textWhite18,));
        }
        return ListView.builder(
            padding:  EdgeInsets.only(top: 10, bottom: playerVisibility ? 70 : 0),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
                return recentsongs.isEmpty ?  Center(child:  Text('No Recent Played !', style: textWhite18,)):
                 ListTile(
                leading: QueryArtworkWidget(
                        artworkBorder: BorderRadius.circular(15),
                        artworkHeight: 90,
                        artworkWidth: 60,
                        id: rsongs[index].id!,
                        type: ArtworkType.AUDIO,
                        artworkFit: BoxFit.cover,
                        nullArtworkWidget: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              'assets/images/music.png',
                              width: 60,
                              height: 90,
                              fit: BoxFit.cover,
                            )),
                      ),
                title: Text(
                 rsongs[index].songname!,
                  style: textWhite18,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  rsongs[index].artist!,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: unSelectedItemClr),
                ),
                // trailing: favPlayListIcons(),
              );
              } ,             
            itemCount:  rsongs.length > 5 ? 5 : rsongs.length,
          );
       }),
           
    );
  }
}