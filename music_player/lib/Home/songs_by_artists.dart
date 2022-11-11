import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_player/constants/style.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../NowPlaying Screen/nowplaying.dart';
import '../settings/settings.dart';
import '../widgets/mini_player.dart';
import 'home_screen.dart';

class SongsByArtistScreen extends StatefulWidget {
  final String artistName;
  // final int artistId;
  const SongsByArtistScreen({
    super.key,
    required this.artistName,
  });

  @override
  State<SongsByArtistScreen> createState() => _SongsByArtistScreenState();
}

class _SongsByArtistScreenState extends State<SongsByArtistScreen> {
  final OnAudioQuery fetchArtistSongs = OnAudioQuery();
  final AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer.withId('0');
  int itemId = 0;
  List<Audio> songsByArtists = [];
  List<SongModel> artistsongs = [];
  List<SongModel> asongs = [];

  @override
  void initState() {
    check();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      
    });
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
      body: 
      FutureBuilder<List<SongModel>>(
        future: fetchArtistSongs.queryAudiosFrom(
            AudiosFromType.ARTIST, widget.artistName,
            sortType: SongSortType.TITLE, orderType: OrderType.ASC_OR_SMALLER),
            builder: (context, item) {
          if(songsByArtists.isEmpty){
            return const Center(child: CircularProgressIndicator());
          }          
          return ListView.builder(
            itemCount: songsByArtists.length,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(top: 10),
            itemBuilder: (context, index) {
            
                return ListTile(
                  onTap: () {
                    // print(songsByArtists);
                    _audioPlayer.open(
                      Playlist(audios: songsByArtists, startIndex: index),
                      showNotification: notificationSwitch,
                      loopMode: LoopMode.playlist,
                    );
                    setState(() {
                      playerVisibility = true;
                      isPlaying = true;
                    });
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return const NowPlayingScreen();
                        },
                      ),
                    );
                  },
                  leading: QueryArtworkWidget(
                    artworkBorder: BorderRadius.circular(15),
                    artworkHeight: 90,
                    artworkWidth: 60,
                    id: artistsongs[index].id,
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
                    artistsongs[index].title,
                    style: textWhite18,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    artistsongs[index].artist!,
                    style: TextStyle(color: unSelectedItemClr),
                    overflow: TextOverflow.ellipsis,
                  ),
                  // trailing: FavIcons(index: index,),
                );
              },
          );
        },
      ),
    );
  }

  check() async {
    final item = await fetchArtistSongs.queryAudiosFrom(
        AudiosFromType.ARTIST, widget.artistName,
        sortType: SongSortType.TITLE, orderType: OrderType.ASC_OR_SMALLER);
    for (int i = 0; i < item.length; i++) {
      if (item[i].fileExtension == 'mp3') {
        artistsongs.add(item[i]);
      }
    }
    for (var songs in artistsongs) {
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
  }
}
