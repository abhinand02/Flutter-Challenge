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
  List<Audio> songs =  [];

  @override
  void initState() {
    List<MostPlayed> songlist =mostplayedsongs.values.toList();

    for(var items in songlist){
      songs.add(Audio.file(items.songurl,metas: Metas(title: items.songname,artist: items.artist,id: items.id.toString())));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     getMostPlayed();
    return Scaffold(
      body: ValueListenableBuilder(valueListenable: mostplayedsongs.listenable(),
       builder: (context,Box<MostPlayed> mpsongsbox,_ ){
        List<MostPlayed> msSongs = mpsongsbox.values.toList();
        int index1= getMostPlayed();
        return ListView.builder(
        physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return ListTile(
                onTap:(){ audioPlayer.open(
                          Playlist(audios: songs, startIndex: index1),
                          showNotification: true,
                        );
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MusicPlayerScreen(index: index1)));
                        },
                leading: QueryArtworkWidget(
                        artworkBorder: BorderRadius.circular(15),
                        artworkHeight: 90,
                        artworkWidth: 60,
                        id: msSongs[index1].id,
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
                  msSongs[index1].songname,
                  style: textWhite18,
                ),
                subtitle: Text(
                  'Adele',
                  style: TextStyle(color: unSelectedItemClr),
                ),
                trailing: HomePlaylistButton(songindex: index1),
              );
            },
            itemCount: 1,
          );
       })
      
    );
  }
}

 int getMostPlayed(){
 List<MostPlayed> songs=  mostplayedsongs.values.toList();
  int large =0;
 for(int i=0;i<songs.length-1;i++){
  for(int j =0;j<songs.length;j++){
if(songs[i].count < songs[j].count){
     large = j;
  }
  } 
 }
 return large;
  // print(large);
}