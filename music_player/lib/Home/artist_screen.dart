import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../constants/style.dart';
import 'home_screen.dart';
import 'songs_by_artists.dart';

class Artist extends StatefulWidget {
  const Artist({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  State<Artist> createState() => _ArtistState();
}

List<ArtistModel> artistList = [];

class _ArtistState extends State<Artist> {
  OnAudioQuery fetchartist = OnAudioQuery();
  late int newIndex;
  int count = 0;
  int count1 = 1;

  @override
  void initState() {
    getArtist();
    super.initState();
  }

  void getArtist() async {
    artistList = await fetchartist.queryArtists();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ArtistModel>>(
      future: fetchartist.queryArtists(),
      builder: (context, item) {
        if (item.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (item.data!.isEmpty) {
          return Center(
            child: Text(
              'No Artist Found!',
              style: textWhite18,
            ),
          );
        }
        return GridView.builder(
          padding: EdgeInsets.only(top: 10, bottom: playerVisibility ? 70 : 0),
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: (1),
          ),
          itemCount: artistList.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                GestureDetector(
                  onTap: () {
                    // print(artistList[index].numberOfTracks);

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return SongsByArtistScreen(
                              artistId: artistList[index].id,
                              artistName: artistList[index].artist);
                        },
                      ),
                    );
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.only(top: 10, left: 20, right: 20),
                    color: backGroundColor,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/images/music.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Text(
                  artistList[index].artist.split(',')[0].toString(),
                  style: textWhite18,
                ),
                Text(
                  'Songs ${artistList[index].numberOfTracks.toString()} ',
                  style: textgrey18,
                ),
              ],
            );
          },
        );
      },
    );
  }
}
