import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/Model/playlistmodel.dart';
import 'package:music_player/Model/recentsong_model.dart';
import 'favmodel.dart';
import 'mostplayed_model.dart';

late Box<PlaylistSongs>playlistbox;
openDatabase()async {
    playlistbox = await Hive.openBox<PlaylistSongs>('playlist');
    // playlistbox.clear();
}

late Box<FavSongs> favdbsongs;
openfavdb()async {
favdbsongs = await Hive.openBox<FavSongs>('favsongs');
}

late Box<MostPlayed> mostplayedsongs;
openmostplayeddb() async{
mostplayedsongs = await Hive.openBox('mostplayed');

}

late Box<RecentPlayed> recentlyplayedbox;
openrecentlyplayedDb()async{
  recentlyplayedbox =  await Hive.openBox('recentlyplayed');
  RecentPlayed value = RecentPlayed(songname: null, artist: null, duration: null, songurl: null, id: null);
  recentlyplayedbox.add(value);
}

updatePlayedSongCount(MostPlayed value, int index){
 int count = value.count;
 value.count=count + 1;
 mostplayedsongs.put(index, value);
 print("this song played  ${value.count} times");
}

recentlyplayedInitial(){
  RecentPlayed value = RecentPlayed(id: 1);
  recentlyplayedbox.add(value);
}

updateRecentlyPlayed(RecentPlayed value){
  // recentlyplayedbox.clear();
 recentlyplayedbox.put(1, value);
 print(recentlyplayedbox.values.toList());
}
