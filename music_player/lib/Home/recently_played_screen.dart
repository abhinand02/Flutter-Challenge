import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/Model/recentsong_model.dart';
import 'package:music_player/player/player.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../Model/db_functions.dart';
import '../constants/style.dart';
import 'home_screen.dart';

class RecentlyPlayedScreen extends StatefulWidget {
  const RecentlyPlayedScreen({super.key});

  @override
  State<RecentlyPlayedScreen> createState() => _RecentlyPlayedScreenState();
}

class _RecentlyPlayedScreenState extends State<RecentlyPlayedScreen> {
  final AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer.withId('0');
  List<Audio> resongs = [];
  @override
  void initState() {
    List<RecentPlayed> rdbsongs = recentlyplayedbox.values.toList().reversed.toList();

    for (var item in rdbsongs) {
      resongs.add(
        Audio.file(
          item.songurl!,
          metas: Metas(
            title: item.songname,
            artist: item.artist,
            id: item.id.toString(),
          ),
        ),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<Box<RecentPlayed>>(
          valueListenable: recentlyplayedbox.listenable(),
          builder: (context, Box<RecentPlayed> recentsongs, _) {
            List<RecentPlayed> rsongs =
                recentsongs.values.toList().reversed.toList();

            if (rsongs.isEmpty) {
              return Center(
                  child: Text(
                'No Recently played',
                style: textWhite18,
              ),);
            }
            return ListView.builder(
              padding:
                  EdgeInsets.only(top: 10, bottom: playerVisibility ? 70 : 0),
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              itemBuilder: (context, index) {
                return recentsongs.isEmpty
                    ? Center(
                        child: Text(
                        'No Recent Played !',
                        style: textWhite18,
                      ))
                    : ListTile(
                        onTap: () {
                          _audioPlayer.open(
                            Playlist(audios: resongs, startIndex: index),
                            showNotification: true,
                            loopMode: LoopMode.none,
                          );
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  MusicPlayerScreen(index: index),
                            ),
                          );
                        },
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
              },
              itemCount: rsongs.length > 5 ? 5 : rsongs.length,
            );
          }),
    );
  }
}
