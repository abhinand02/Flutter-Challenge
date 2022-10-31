import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/Model/model.dart';
import 'package:music_player/Playlist/songs_by_playlist.dart';
import 'package:music_player/Splash%20Screen/splashscreen.dart';
import 'package:music_player/widgets/method.dart';
import '../Model/db_functions.dart';
import '../Model/playlistmodel.dart';
import '../constants/style.dart';
import '../main.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  List<PlaylistSongs> playlists = [];
  List<Songs> playlistsong = [];
  final formkey = GlobalKey<FormState>();
  TextEditingController textcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Playlists'),
      body: ValueListenableBuilder<Box<PlaylistSongs>>(
        valueListenable: playlistbox.listenable(),
        builder: (context, Box<PlaylistSongs> value, child) {
          playlists = value.values.toList();
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              value.isEmpty
                  ? Center(
                      child: Text(
                        'No Playlist!',
                        style: textWhite18,
                      ),
                    )
                  : Flexible(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          playlistsong = playlists[index].playlistsongs!;
                          TextEditingController textController =
                              TextEditingController(
                                  text: playlists[index].playlistname);
                          return ListTile(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return SongsByPlaylistScreen(
                                  playlistname: playlists[index].playlistname,
                                  playlistindex: index,
                                  allPlaylistSongs:
                                      playlists[index].playlistsongs!,
                                );
                              }));
                            },
                            leading: Icon(
                              Icons.headphones_rounded,
                              color: selectedItemColor,
                              size: 30,
                            ),
                            title: Text(
                              playlists[index].playlistname,
                              style: textWhite18,
                            ),
                            trailing: PopupMenuButton(
                              color: isDarkMode ? backGroundColor : whiteClr,
                              icon: const Icon(
                                Icons.more_vert,
                              ),
                              itemBuilder: (_) => <PopupMenuItem<int>>[
                                PopupMenuItem(
                                  value: 0,
                                  child: SizedBox(
                                    width: 80,
                                    child: Text(
                                      'Rename',
                                      style: text18,
                                    ),
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 1,
                                  child: SizedBox(
                                    width: 80,
                                    child: Text(
                                      'Delete',
                                      style: text18,
                                    ),
                                  ),
                                )
                              ],
                              onSelected: (selectedindex) async {
                                switch (selectedindex) {
                                  case 0:
                                    showModalBottomSheet(
                                      backgroundColor:
                                          const Color.fromARGB(255, 23, 23, 24),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      context: context,
                                      builder: (context) {
                                        return editBottom(
                                            context,
                                            textController,
                                            index,
                                            playlistsong);
                                      },
                                    );
                                    break;
                                  case 1:
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          backgroundColor: backGroundColor,
                                          content: Text(
                                            'Do you want to delete ?',
                                            style: TextStyle(
                                                color: whiteClr, fontSize: 18),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                playlistbox.deleteAt(index);
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                'Yes',
                                                style: TextStyle(
                                                    color: whiteClr,
                                                    fontSize: 18),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                'No',
                                                style: TextStyle(
                                                    color: whiteClr,
                                                    fontSize: 18),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                }
                              },
                            ),
                          );
                        },
                        itemCount: playlists.length,
                      ),
                    ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: selectedItemColor,
                    elevation: 1,
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.all(10)),
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: const Color.fromARGB(255, 23, 23, 24),
                    context: context,
                    builder: (context) {
                      return bottomSheet(context);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  );
                },
                icon: const Icon(Icons.add),
                label: Text(
                  'Create Playlist',
                  style: text18,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget editBottom(BuildContext context, TextEditingController textcontroller,
      int index, List<Songs> playlistsong) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          left: 10,
          right: 10,
          top: 20),
      child: Container(
        height: width * .7,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          color: Color.fromARGB(255, 23, 23, 24),
        ),
        child: Column(
          children: [
            Text(
              'Edit Playlist',
              style: TextStyle(fontSize: 22, color: whiteClr),
            ),
            height10,
            Form(
              key: formkey,
              child: TextFormField(
                style: TextStyle(color: blackClr, fontSize: 18),
                autofocus: true,
                controller: textcontroller,
                cursorHeight: 25,
                decoration: InputDecoration(
                  hintText: 'Playlist name',
                  hintStyle: TextStyle(fontSize: 18, color: blackClr),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none),
                  fillColor: whiteClr,
                  filled: true,
                ),
                validator: (value) {
            
                  // bool isAlreadyAdded = values
                  //     .where((element) => element.playlistname == value!.trim())
                  //     .isNotEmpty;
            
                  if (value!.trim() == '') {
                    return 'Name Required';
                  }
                  // if (isAlreadyAdded) {
                  //   return 'This Name Already Exist';
                  // }
                  return null;
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      backgroundColor: selectedItemColor),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Cancel',
                      style: textWhite18,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if(formkey.currentState!.validate()){
                      playlistbox.putAt(
                        index,
                        PlaylistSongs(
                            playlistname: textcontroller.text,
                            playlistsongs: playlistsong),
                            );
                            Navigator.pop(context);
                    }
                    textcontroller.clear();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: selectedItemColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Edit',
                      style: text18,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget bottomSheet(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 10),
      child: Container(
        height: width * .7,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          color: Color.fromARGB(255, 23, 23, 24),
        ),
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
        ),
        child: Column(
          children: [
            playlistForm(context),
          ],
        ),
      ),
    );
  }

  Column playlistForm(BuildContext context) {
    return Column(
      children: [
        Text(
          'Create Playlist',
          style: TextStyle(color: whiteClr, fontSize: 22),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Form(
            key: formkey,
            child: TextFormField(
              style: TextStyle(color: blackClr, fontSize: 18),
              autofocus: true,
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
        ),
        formButtons(context)
      ],
    );
  }

  Row formButtons(BuildContext context1) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context1).pop();
          },
          style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(), backgroundColor: selectedItemColor),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Cancel',
              style: textWhite18,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if(formkey.currentState!.validate()){
              playlistbox.add(PlaylistSongs(
                playlistname: textcontroller.text, playlistsongs: []));
            Navigator.pop(context);
            } 
           textcontroller.clear();
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            backgroundColor: selectedItemColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Create',
              style: text18,
            ),
          ),
        ),
      ],
    );
  }
}
