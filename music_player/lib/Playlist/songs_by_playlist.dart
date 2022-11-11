import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/Home/home_screen.dart';
import 'package:music_player/Model/db_functions.dart';
import 'package:music_player/Model/playlistmodel.dart';
import 'package:music_player/NowPlaying%20Screen/nowplaying.dart';
import 'package:music_player/Playlist/addtoPlaylist.dart';
import 'package:music_player/widgets/method.dart';
import 'package:music_player/widgets/mini_player.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../Model/model.dart';
import '../constants/style.dart';
import '../settings/settings.dart';

List<Songs>? songs = [];
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
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: backGroundColor,
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  ),
                  context: context,
                  builder: (context) {
                    return  AddToPlaylist(playlistIndex: widget.playlistindex,);
                  },
                );
              },
              icon: const Icon(Icons.add_rounded),
              splashRadius: 20,
            )),
        body: ValueListenableBuilder<Box<PlaylistSongs>>(
          valueListenable: playlistbox.listenable(),
          builder: (context, value, _) {
            List<PlaylistSongs> plsongs = playlistbox.values.toList();
            songs = plsongs[widget.playlistindex].playlistsongs;

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
                      showNotification: notificationSwitch,
                    );
                    setState(() {
                      playerVisibility= true;
                      isPlaying=true;
                    });
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const NowPlayingScreen()));
                  },
                  leading: QueryArtworkWidget(
              id: songs![index].id,
              type: ArtworkType.AUDIO,
              artworkHeight: 90,
              artworkWidth: 60,
              artworkBorder: BorderRadius.circular(15),
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
                    songs![index].songname,
                    style: textWhite18,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    songs![index].artist,
                    style: TextStyle(color: unSelectedItemClr),
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Padding(
                    padding: const EdgeInsets.only(bottom: 20, right: 10),
                    child: IconButton(
                        onPressed: () {
                          setState(
                            () {
                              songs!.removeAt(index);
                              playlistbox.putAt(
                                  widget.playlistindex,
                                  PlaylistSongs(
                                      playlistname: widget.playlistname,
                                      playlistsongs: songs),);
                            },
                          );
                      //     ScaffoldMessenger.of(context).showSnackBar(
                      // SnackBar(
                      //   backgroundColor: selectedItemColor,
                      //   duration: const Duration(seconds: 1),
                      //   margin: const EdgeInsets.symmetric(
                      //       horizontal: 10, vertical: 10),
                      //   behavior: SnackBarBehavior.floating,
                      //   shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(10)),
                      //   content: Text(
                      //       '${plstsongs[index].metas.title} Removed from ${widget.playlistname}'),
                      // ),
                    // );
                        },
                        icon:const Icon(
                          Icons.remove_outlined,
                        )),
                  ),
                );
              },
              itemCount: songs!.length,
            );
          },
        ));
  }
}
