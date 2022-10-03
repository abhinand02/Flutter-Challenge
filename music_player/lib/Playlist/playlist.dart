import 'package:flutter/material.dart';
import 'package:music_player/Playlist/songs_by_playlist.dart';
import 'package:music_player/widgets/method.dart';
import '../constants/style.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Playlists'),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const SongsByPlaylistScreen();
                    }));
                  },
                  leading: Icon(
                    Icons.headphones_rounded,
                    color: selectedItemColor,
                    size: 30,
                  ),
                  title: Text(
                    'Playlist ${index + 1}',
                    style: textWhite18,
                  ),
                );
              },
              itemCount: 2,
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
                context: context,
                builder: (context) {
                  return bottomSheet(context);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                )
              );
            },
            icon: const Icon(Icons.add),
            label: Text(
              'Create Playlist',
              style: text18,
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomSheet(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  color:  Color.fromARGB(255, 23, 23, 24),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        children: [playlistForm(context)],
      ),
    );
  }

  Column playlistForm(BuildContext context) {
    return Column(
      children: [
        Text(
          'Create Playlist',
          style: textWhite22,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: TextField(
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
          onPressed: () {},
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
