import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_player/constants/style.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../player/player.dart';
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(height / 2.5),
          child: Stack(
            children: [
              SizedBox(
                width: width,
                child: const ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  child: Image(
                    image: AssetImage('assets/images/Frame 38.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 20,
                child: Text(
                  widget.artistName.split(',')[0].toString(),
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: whiteClr),
                ),
              ),
            ],
          ),
        ),
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
                  songsByArtists.add(Audio.file(songs.uri.toString(),
                      metas: Metas(
                          title: songs.title,
                          artist: songs.artist,
                          id: songs.id.toString())));
                }
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
                            index: index,
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
                        )),
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
              },
              itemCount: item.data!.length,
            );
          },
        ));
  }
}
