import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/Model/db_functions.dart';
import 'package:music_player/Model/playlistmodel.dart';
import 'package:music_player/NowPlaying%20Screen/nowplaying.dart';
import 'package:music_player/widgets/method.dart';
import '../Model/model.dart';
import '../constants/style.dart';

class SongsByPlaylistScreen extends StatefulWidget {
  SongsByPlaylistScreen(
      {super.key,
      required this.playlistname,
      required this.playlistindex,
      required this.allPlaylistSongs});

  String playlistname;
  int playlistindex;
  List<Songs> allPlaylistSongs = [];

  @override
  State<SongsByPlaylistScreen> createState() => _SongsByPlaylistScreenState();
}

class _SongsByPlaylistScreenState extends State<SongsByPlaylistScreen> {
  AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');

  List<Audio> plstsongs = [];

  @override
  void initState() {
    super.initState();
    for (var song in widget.allPlaylistSongs) {
      plstsongs.add(Audio.file(song.songurl,
          metas: Metas(
              title: song.songname,
              artist: song.artist,
              id: song.id.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(
          widget.playlistname,
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            splashRadius: 25,
          ),
        ),
        body: ValueListenableBuilder<Box<PlaylistSongs>>(
          valueListenable: playlistbox.listenable(),
          builder: (context, value, _) {
            List<PlaylistSongs> plsongs = playlistbox.values.toList();
            List<Songs>? songs = plsongs[widget.playlistindex].playlistsongs;

            if (songs!.isEmpty) {
              return Center(
                child: Text(
                  'No Songs Added !',
                  style: textWhite18,
                ),
              );
            }
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    player.open(
                      Playlist(audios: plstsongs, startIndex: index),
                      showNotification: true,
                    );
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MusicPlayerScreen()));
                  },
                  leading: const Image(
                      image: AssetImage('assets/images/music-removebg.png')),
                  title: Text(
                    songs[index].songname,
                    style: textWhite18,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    songs[index].artist,
                    style: TextStyle(color: unSelectedItemClr),
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Padding(
                    padding: const EdgeInsets.only(bottom: 20, right: 10),
                    child: IconButton(
                        onPressed: () {
                          setState(
                            () {
                              songs.removeAt(index);
                              plstsongs.removeAt(index);
                              playlistbox.putAt(
                                  widget.playlistindex,
                                  PlaylistSongs(
                                      playlistname: widget.playlistname,
                                      playlistsongs: songs));
                            },
                          );
                        },
                        icon: Icon(
                          Icons.remove_outlined,
                          color: whiteClr,
                        )),
                  ),
                );
              },
              itemCount: songs.length,
            );
          },
        ));
  }
}
