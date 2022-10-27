import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/Model/playlistmodel.dart';
import 'package:music_player/Model/recentsong_model.dart';
import 'favmodel.dart';
import 'mostplayed_model.dart';

late Box<PlaylistSongs> playlistbox;
openDatabase() async {
  playlistbox = await Hive.openBox<PlaylistSongs>('playlist');
  // playlistbox.clear();
}

late Box<FavSongs> favdbsongs;
openfavdb() async {
  favdbsongs = await Hive.openBox<FavSongs>('favsongs');
}

late Box<MostPlayed> mostplayedsongs;
openmostplayeddb() async {
  mostplayedsongs = await Hive.openBox('mostplayed');
}

late Box<RecentPlayed> recentlyplayedbox;
openrecentlyplayedDb() async {
  recentlyplayedbox = await Hive.openBox('recentlyplayed');
}

updatePlayedSongCount(MostPlayed value, int index) {
  int count = value.count;
  value.count = count + 1;
  mostplayedsongs.put(index, value);
//  print("this song played  ${value.count} times");
}

updateRecentlyPlayed(RecentPlayed value) {
  // recentlyplayedbox.clear();
  // mostplayedsongs.clear();
  List<RecentPlayed> list = recentlyplayedbox.values.toList();
  bool isAlready =
      list.where((element) => element.songname == value.songname).isNotEmpty;

  if (isAlready == false) {
    recentlyplayedbox.add(value);

    // print(recentlyplayedbox.values.toList());
  } else {
    int index =
        list.indexWhere((element) => element.songname == value.songname);

    recentlyplayedbox.deleteAt(index);
    recentlyplayedbox.add(value);
  }
}
