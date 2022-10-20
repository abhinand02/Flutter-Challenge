import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/constants/style.dart';
import '../Model/db_functions.dart';
import '../Model/model.dart';
import '../Model/playlistmodel.dart';

bool textformVisibility= false;
class HomePlaylistButton extends StatelessWidget {
  int songindex;
  HomePlaylistButton({
    Key? key,
    required this.songindex,
  }) : super(key: key);
  TextEditingController textcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        playlistBottomSheet(context);
      },
      icon: const Icon(Icons.playlist_add),
      color: whiteClr,
      splashRadius: 20,
    );
  }

  Future<dynamic> playlistBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) => Container(
              color: backGroundColor,
              child: ValueListenableBuilder<Box<PlaylistSongs>>(
                  valueListenable: playlistbox.listenable(),
                  builder: (context, Box<PlaylistSongs> playlistbox, _) {
                    List<PlaylistSongs> playlist = playlistbox.values.toList();

                    if (playlistbox.isEmpty) {
                      return const ifNoPlaylist();
                    }
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              itemCount: playlist.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: Icon(
                                    Icons.headphones_rounded,
                                    color: whiteClr,
                                  ),
                                  title: Text(
                                    playlist[index].playlistname,
                                    style: textWhite18,
                                  ),
                                  onTap: () {
                                    PlaylistSongs? plsongs =
                                        playlistbox.getAt(index);
                                    List<Songs>? plnewsongs =
                                        plsongs!.playlistsongs;
                                    Box<Songs> box = Hive.box('Songs');
                                    List<Songs> dbAllsongs =
                                        box.values.toList();
                                    bool isAlreadyAdded = plnewsongs!.any(
                                        (element) =>
                                            element.id ==
                                            dbAllsongs[songindex].id);

                                    if (!isAlreadyAdded) {
                                      plnewsongs.add(Songs(
                                        songname:
                                            dbAllsongs[songindex].songname,
                                        artist: dbAllsongs[songindex].artist,
                                        duration:
                                            dbAllsongs[songindex].duration,
                                        songurl: dbAllsongs[songindex].songurl,
                                        id: dbAllsongs[songindex].id,
                                      ));

                                      playlistbox.putAt(
                                          index,
                                          PlaylistSongs(
                                              playlistname:
                                                  playlist[index].playlistname,
                                              playlistsongs: plnewsongs));

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              backgroundColor:
                                                  selectedItemColor,
                                              content: Text(
                                                  '${dbAllsongs[songindex].songname}Added to ${playlist[index].playlistname}')));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              backgroundColor:
                                                  selectedItemColor,
                                              content: Text(
                                                  '${dbAllsongs[songindex].songname} is already added')));
                                    }
                                    Navigator.pop(context);
                                  },
                                );
                              }),
                        )
                      ],
                    );
                  }),
            ),
          );
        });
  }
}

class ifNoPlaylist extends StatefulWidget {
  const ifNoPlaylist({
    Key? key,
  }) : super(key: key);

 

  @override
  State<ifNoPlaylist> createState() => _ifNoPlaylistState();
}

class _ifNoPlaylistState extends State<ifNoPlaylist> {
    TextEditingController textcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          textformVisibility ? 'Create Playlist' : 'No Playlists',
          style: textWhite22,
        ),
        Visibility(
          visible: textformVisibility,
          child: TextFormField(
                    controller: textcontroller,
                    cursorHeight: 25,
                    decoration: InputDecoration(
                      hintText: 'Playlist name',
                      hintStyle: text18,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none),
                      fillColor: whiteClr,
                      filled: true,
                    ),
                    validator: (value) {
                      List<PlaylistSongs> values = playlistbox.values.toList();
        
                      bool isAlreadyAdded = values
                          .where((element) => element.playlistname == value!.trim())
                          .isNotEmpty;
        
                      if (value!.trim() == '') {
                        return 'Name Required';
                      }
                      if (isAlreadyAdded) {
                        return 'This Name Already Exist';
                      }
                      return null;
                    },
                  ),
        ),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
              backgroundColor: selectedItemColor,
              elevation: 1,
              shape: const StadiumBorder(),
              padding: const EdgeInsets.all(10)),
          onPressed: () {
          textformVisibility == false ?  setState(() {
              textformVisibility=true;
            }) :
            playlistbox.add(PlaylistSongs(
                playlistname: textcontroller.text,
                playlistsongs: []));
            Navigator.pop(context);
          },
          icon: const Icon(Icons.add),
          label: Text(
            'Create Playlist',
            style: text18,
          ),
        ),
      ],
    );
  }
}
