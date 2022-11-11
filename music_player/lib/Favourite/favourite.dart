import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/Model/db_functions.dart';
import 'package:music_player/Model/model.dart';
import 'package:music_player/constants/style.dart';
import 'package:music_player/NowPlaying%20Screen/nowplaying.dart';
import 'package:music_player/widgets/method.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../Home/home_screen.dart';
import '../Model/favmodel.dart';
import '../Model/mostplayed_model.dart';
import '../Model/recentsong_model.dart';
import '../settings/settings.dart';
import '../widgets/mini_player.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

List<Audio> allsongs = [];

class _FavoriteScreenState extends State<FavoriteScreen> {
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
  final dbsongs = SongBox.getInstance().values.toList();
  @override
  void initState() {
    final DBfavsongs = Hive.box<FavSongs>('favsongs').values.toList();

    for (var item in DBfavsongs) {
      allsongs.add(Audio.file(item.songurl,
          metas: Metas(
              artist: item.artist,
              title: item.songname,
              id: item.id.toString())));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Favourites'),
      body: ValueListenableBuilder<Box<FavSongs>>(
        valueListenable: Hive.box<FavSongs>('favsongs').listenable(),
        builder: (context, Box<FavSongs> alldbfavsongs, child) {
          List<FavSongs> allfavsongs = alldbfavsongs.values.toList();

          if (favdbsongs.isEmpty) {
            return Center(
              child: Text(
                'No Songs Added',
                style: textWhite18,
              ),
            );
          }
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                onTap: () {
                  
                final  rsongs = RecentPlayed(
                              songname: allfavsongs[index].songname,
                              artist: allfavsongs[index].artist,
                              duration: allfavsongs[index].duration,
                              songurl: allfavsongs[index].songurl,
                              id: allfavsongs[index].id);
                          updateRecentlyPlayed(rsongs);
                          int songIndex = dbsongs.indexWhere((element) => element.songname == allfavsongs[index].songname);
                          MostPlayed msongs = mostplayedsongs.values.toList()[songIndex];
                          updatePlayedSongCount(msongs, index);

                  setState(() {
                    playerVisibility = true;
                    isPlaying = true;
                  });

                  audioPlayer.open(
                    Playlist(audios: allsongs, startIndex: index),
                    showNotification: notificationSwitch,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const NowPlayingScreen(
                        );
                      },
                    ),
                  );
                },
                leading: QueryArtworkWidget(
                  artworkBorder: BorderRadius.circular(15),
                  artworkHeight: 90,
                  artworkWidth: 60,
                  id: allfavsongs[index].id,
                  type: ArtworkType.AUDIO,
                  artworkFit: BoxFit.cover,
                  nullArtworkWidget: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      'assets/images/music.png',
                      width: 60,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(
                  allfavsongs[index].songname,
                  style: textWhite18,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.favorite_rounded),
                  onPressed: () {
                    setState(
                      () {
                        favdbsongs.deleteAt(index);
                        ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: selectedItemColor,
                        duration: const Duration(seconds: 1),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        content: Text(
                            '${allfavsongs[index].songname} Removed from favourites'),
                      ),
                    );
                      },
                    );
                  },
                  color: selectedItemColor,
                ),
              );
            },
            itemCount: allfavsongs.length,
          );
        },
      ),
    );
  }
}
