import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_player/Model/model.dart';
import 'package:music_player/constants/style.dart';
import 'package:music_player/NowPlaying%20Screen/nowplaying.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Search extends SearchDelegate {
  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_rounded));

  @override
  List<Widget>? buildActions(BuildContext context) {
    IconButton(
        icon: const Icon(Icons.close_rounded),
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        });
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Songs> songs = SongBox.getInstance().values.toList();

    final searchitem = query.isEmpty
        ? songs
        : songs
            .where((element) => element.songname
                .toLowerCase()
                .contains(query.toLowerCase().toString()))
            .toList();
    return searchResults(searchitem);
  }
}

Widget searchResults(List<Songs> songs) {
  AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer.withId('0');
  List<Audio> audio = [];
  for (var item in songs) {
    audio.add(
      Audio.file(
        item.songurl,
        metas: Metas(
            title: item.songname, artist: item.artist, id: item.id.toString()),
      ),
    );
  }
  return ListView.builder(
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      return ListTile(
        onTap: () {
          FocusScopeNode currentFocus= FocusScope.of(context);
          if(!currentFocus.hasPrimaryFocus){
            currentFocus.unfocus();
          }
          _audioPlayer.open(
            Playlist(audios: audio, startIndex: index),
            showNotification: true,
            loopMode: LoopMode.playlist,
          );
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => MusicPlayerScreen(),
            ),
          );
        },
        leading: QueryArtworkWidget(
          artworkBorder: BorderRadius.circular(15),
          artworkHeight: 90,
          artworkWidth: 60,
          id: songs[index].id,
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
          songs[index].songname,
          style: textWhite18,
          overflow: TextOverflow.ellipsis,
        ),
        contentPadding: const EdgeInsets.all(10),
      );
    },
    itemCount: songs.length,
  );
}
