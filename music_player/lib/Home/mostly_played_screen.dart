import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/Playlist/homeplaylistbutton.dart';
import 'package:music_player/player/player.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../Model/db_functions.dart';
import '../Model/mostplayed_model.dart';
import '../constants/style.dart';

class MostlyPlayedScreen extends StatefulWidget {
  MostlyPlayedScreen({super.key});

  @override
  State<MostlyPlayedScreen> createState() => _MostlyPlayedScreenState();
}

class _MostlyPlayedScreenState extends State<MostlyPlayedScreen> {
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
  List<Audio> songs = [];

  @override
  void initState() {
    List<MostPlayed> songlist = mostplayedsongs.values.toList();
    int i = 0;
    for (var item in songlist) {
      if (item.count > 5) {
        finalmpsongs.insert(i, item);

        i = i + 1;
      }
    }
    for (var items in finalmpsongs) {
      songs.add(Audio.file(items.songurl,
          metas: Metas(
              title: items.songname,
              artist: items.artist,
              id: items.id.toString())));
    }
    super.initState();
  }
  List<MostPlayed> finalmpsongs = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: mostplayedsongs.listenable(),
        builder: (context, Box<MostPlayed> mpsongsbox, _) {
          if (finalmpsongs.isNotEmpty) {
            return ListView.builder(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    audioPlayer.open(
                      Playlist(audios: songs, startIndex: index),
                      showNotification: true,
                    );
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MusicPlayerScreen(index: index)));
                  },
                  leading: QueryArtworkWidget(
                    artworkBorder: BorderRadius.circular(15),
                    artworkHeight: 90,
                    artworkWidth: 60,
                    id: finalmpsongs[index].id,
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
                    finalmpsongs[index].songname,
                    style: textWhite18,
                  ),
                  subtitle: Text(
                    finalmpsongs[index].artist,
                    style: TextStyle(color: unSelectedItemClr),
                  ),
                  trailing: HomePlaylistButton(songindex: index),
                );
              },
              itemCount: finalmpsongs.length < 4 ? finalmpsongs.length : 4,
            );
          } else {
            return Center(
              child: Text(
                'No Mostly Played Songs',
                style: textWhite18,
              ),
            );
          }
        },
      ),
    );
  }
}
      //  )
      
    // );
// }


//  int getMostPlayed(){
//  List<MostPlayed> songs=  mostplayedsongs.values.toList();
//   int large = 0;
//  for(int i=0;i<songs.length-1;i++){
//   for(int j =0;j<songs.length;j++){
// if(songs[i].count < songs[j].count){
//      large = large;
//   }
// } 
//  }
//  return large;
// }