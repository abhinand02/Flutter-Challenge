import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/Home/home_screen.dart';
import 'package:music_player/Model/recentsong_model.dart';
import 'package:music_player/Playlist/homeplaylistbutton.dart';
import 'package:music_player/NowPlaying%20Screen/nowplaying.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../Model/db_functions.dart';
import '../Model/mostplayed_model.dart';
import '../constants/style.dart';
import '../settings/settings.dart';
import '../widgets/mini_player.dart';

class MostlyPlayedScreen extends StatefulWidget {
  const MostlyPlayedScreen({super.key});

  @override
  State<MostlyPlayedScreen> createState() => _MostlyPlayedScreenState();
}

class _MostlyPlayedScreenState extends State<MostlyPlayedScreen> {
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
  List<Audio> songs = [];
  List<RecentPlayed> rsongs = recentlyplayedbox.values.toList();

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
                MostPlayed msongs = mpsongsbox.values.toList()[index];
                return ListTile(
                  onTap: () {
                    updatePlayedSongCount(msongs, index);
                    updateRecentlyPlayed(rsongs[index]);
                    audioPlayer.open(
                      Playlist(audios: songs, startIndex: index),
                      showNotification: notificationSwitch,
                    );

                    setState(() {
                      playerVisibility=true;
                      isPlaying = true;
                    });
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const NowPlayingScreen()));
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
                      ),
                    ),
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
