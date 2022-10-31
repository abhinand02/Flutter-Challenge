import 'package:flutter/material.dart';
import 'package:music_player/Model/model.dart';
import 'package:music_player/constants/style.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../Model/db_functions.dart';
import '../Model/playlistmodel.dart';

class AddToPlaylist extends StatefulWidget {
  int playlistIndex;
  AddToPlaylist({super.key, required this.playlistIndex});

  @override
  State<AddToPlaylist> createState() => _AddToPlaylistState();
}

class _AddToPlaylistState extends State<AddToPlaylist> {
  List<Songs> song = SongBox.getInstance().values.toList();
  List<PlaylistSongs> psongs = playlistbox.values.toList();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        color: Color.fromARGB(255, 23, 23, 24),
      ),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              PlaylistSongs? plsongs = playlistbox.getAt(widget.playlistIndex);
              List<Songs>? plnewsongs = plsongs!.playlistsongs;
              bool isAlreadyAdded = plnewsongs!.any((element) => element.id == song[index].id);
              
              if (!isAlreadyAdded) {
                plnewsongs.add(
                  Songs(
                    songname: song[index].songname,
                    artist: song[index].artist,
                    duration: song[index].duration,
                    songurl: song[index].songurl,
                    id: song[index].id,
                  ),
                );
                 
                playlistbox.putAt(
                    widget.playlistIndex,
                    PlaylistSongs(
                        playlistname: psongs[widget.playlistIndex].playlistname,
                        playlistsongs: plnewsongs),);
        
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: selectedItemColor,
                    duration: const Duration(seconds: 1),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    content: Text(
                        '${song[index].songname}Added to ${psongs[widget.playlistIndex].playlistname}'),),);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: selectedItemColor,
                    duration: const Duration(seconds: 1),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    content:
                        Text('${song[index].songname} is already added')));
              }
              
              Navigator.pop(context);
            },
            contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            leading: QueryArtworkWidget(
              id: song[index].id,
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
              song[index].songname,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 18, color: whiteClr),
            ),
          );
        },
        itemCount: song.length,
      ),
    );
  }
}
