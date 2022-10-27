import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/Model/db_functions.dart';
import 'package:music_player/constants/style.dart';
import 'package:music_player/NowPlaying%20Screen/nowplaying.dart';
import 'package:music_player/widgets/method.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../Home/home_screen.dart';
import '../Model/favmodel.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

List<Audio> allsongs = [];

class _FavoriteScreenState extends State<FavoriteScreen> {
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');

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
                minVerticalPadding: 20,
                onTap: () {
                  // print(allsongs);
                  playerVisibility = true;

                  audioPlayer.open(
                    Playlist(audios: allsongs, startIndex: index),
                    showNotification: true,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return MusicPlayerScreen(
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
