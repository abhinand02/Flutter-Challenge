import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_player/constants/style.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../NowPlaying Screen/nowplaying.dart';
import '../widgets/mini_player.dart';
import 'home_screen.dart';

class SongsByArtistScreen extends StatefulWidget {
  final String artistName;
  final int artistId;
  const SongsByArtistScreen(
      {super.key, required this.artistName, required this.artistId});

  @override
  State<SongsByArtistScreen> createState() => _SongsByArtistScreenState();
}

class _SongsByArtistScreenState extends State<SongsByArtistScreen> {
  final OnAudioQuery fetchArtistSongs = OnAudioQuery();
  final AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer.withId('0');
  int itemId = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: AppBar(
              title: Text(
                widget.artistName,
                style: textWhite22,
              ),
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(29))),
            )),
        body: FutureBuilder<List<SongModel>>(
          future: fetchArtistSongs.queryAudiosFrom(
              AudiosFromType.ARTIST_ID, widget.artistId,
              sortType: SongSortType.TITLE,
              orderType: OrderType.ASC_OR_SMALLER),
          builder: (context, item) {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(top: 10),
              itemBuilder: (context, index) {
                List<Audio> songsByArtists = [];
                for (var songs in item.data!) {
                  itemId = songs.id;
                  songsByArtists.add(
                    Audio.file(
                      songs.uri.toString(),
                      metas: Metas(
                        title: songs.title,
                        artist: songs.artist,
                        id: songs.id.toString(),
                      ),
                    ),
                  );
                }

                if (item.data == null) {
                  return const Text('no Songs');
                } else {
                  return ListTile(
                    onTap: () {
                      _audioPlayer.open(
                        Playlist(audios: songsByArtists, startIndex: index),
                        showNotification: true,
                      );
                      playerVisibility = true;
                      isPlaying = true;
                      const HomeScreen();
                      Navigator.of(context).push(
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
                      id: itemId,
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
                      songsByArtists[index].metas.title.toString(),
                      style: textWhite18,
                    ),
                    subtitle: Text(
                      songsByArtists[index].metas.artist.toString(),
                      style: TextStyle(color: unSelectedItemClr),
                      overflow: TextOverflow.ellipsis,
                    ),
                    // trailing: favPlayListIcons(),
                  );
                }
              },
              itemCount: item.data != null ? item.data?.length : 0,
            );
          },
        ));
  }
}
