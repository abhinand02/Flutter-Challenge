import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/Home/mostly_played_screen.dart';
import 'package:music_player/Home/recently_played_screen.dart';
import 'package:music_player/Home/search.dart';
import 'package:music_player/Model/db_functions.dart';
import 'package:music_player/Model/model.dart';
import 'package:music_player/Model/mostplayed_model.dart';
import 'package:music_player/Model/recentsong_model.dart';
import 'package:music_player/constants/style.dart';
import 'package:music_player/NowPlaying%20Screen/nowplaying.dart';
import 'package:music_player/main.dart';
import 'package:music_player/settings/settings.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Favourite/favourite_function.dart';
import '../widgets/mini_player.dart';
import 'artist_screen.dart';

bool playerVisibility = false;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const isFirstPageLaunch = "PREFERENCES_IS_FIRST_LAUNCH_STRING";
  static const isLaunchFirstPage = "Launch";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final box = SongBox.getInstance();
  List<Audio> allSongs = [];

  final AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer.withId('0');

  @override
  void initState() {
    super.initState();
    List<Songs> dbSongs = box.values.toList();

    for (var item in dbSongs) {
      allSongs.add(
        Audio.file(
          item.songurl,
          metas: Metas(
            artist: item.artist,
            title: item.songname,
            id: item.id.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(height / 5),
          child: appBar(height),
        ),
        body: TabBarView(
          physics: const BouncingScrollPhysics(),
          children: [
            ValueListenableBuilder<Box<Songs>>(
                valueListenable: box.listenable(),
                builder: (context, Box<Songs> allboxsong, child) {
                  List<Songs> allDbSongs = allboxsong.values.toList();
                  List<MostPlayed> allmostplayedsongs =
                      mostplayedsongs.values.toList();
                  if (allDbSongs.isEmpty) {
                    // print(allDbSongs);

                    return Center(
                      child: Text(
                        'No Songs Found!',
                        style:isDarkMode ?  textWhite18 :  text18,
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: EdgeInsets.only(
                        top: 10, bottom: playerVisibility ? 70 : 0),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      Songs songs = allDbSongs[index];
                      MostPlayed msongs = allmostplayedsongs[index];
                      RecentPlayed rsongs;
                      return ListTile(
                        onTap: () {
                          rsongs = RecentPlayed(
                              songname: songs.songname,
                              artist: songs.artist,
                              duration: songs.duration,
                              songurl: songs.songurl,
                              id: songs.id);
                          updateRecentlyPlayed(rsongs);
                          updatePlayedSongCount(msongs, index);
                          _audioPlayer.open(
                            Playlist(audios: allSongs, startIndex: index),
                            showNotification: notificationSwitch,
                            loopMode: LoopMode.playlist,
                            headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplugPlayOnPlug
                          );
                          // print("this song played  $count times");
                          // print(recentlyplayedbox.values.toList()[index]);
                          setState(
                            () {
                              playerVisibility = true;
                              isPlaying = true;
                            },
                          );
                          _isFirst().then(
                            (value) {
                              if (value == false) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                       const NowPlayingScreen())).then((value) => setState((){}));
                              }
                            },
                          );
                        },
                        leading: QueryArtworkWidget(
                          artworkBorder: BorderRadius.circular(15),
                          artworkHeight: 90,
                          artworkWidth: 60,
                          id: songs.id,
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
                          songs.songname,
                          style: isDarkMode ? textWhite18 : text18,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          songs.artist,
                          style: TextStyle(color: unSelectedItemClr),
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: FavIcons(
                          index: index,
                        ),
                      );
                    },
                    itemCount: allDbSongs.length,
                  );
                }),
            Artist(width: width),
            const RecentlyPlayedScreen(),
            const MostlyPlayedScreen(),
          ],
        ),
        bottomSheet:
            Visibility(visible: playerVisibility, child: const MiniPlayer()),
      ),
    );
  }

  AppBar appBar(double height) {
    return AppBar(
      elevation: 1,
      // backgroundColor:isDarkMode ? backGroundColor : whiteClr,
      toolbarHeight: height * .5,
      leadingWidth: height * .2,
      leading: const Image(
        image: AssetImage('assets/images/music-removebg.png'),
      ),
      actions: [
        IconButton(
            onPressed: () {
              showSearch(context: context, delegate: Search());
            },
            icon: const Icon(Icons.search_rounded),iconSize: 33,)
      ],
      bottom: TabBar(
        physics: const BouncingScrollPhysics(),
        isScrollable: true,
        indicatorWeight: 4,
        indicatorColor: selectedItemColor,
        labelColor: selectedItemColor,
        unselectedLabelColor: unSelectedItemClr,
        tabs: [
          tabbarTitle(title: 'Songs'),
          tabbarTitle(title: 'Artist'),
          tabbarTitle(title: 'Recently Played'),
          tabbarTitle(title: 'Mostly Played'),
        ],
      ),
    );
  }

  Future<bool> _isFirst() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    bool isFirstLaunch =
        sharedPreferences.getBool(HomeScreen.isLaunchFirstPage) ?? true;

    if (isFirstLaunch) {
      sharedPreferences.setBool(HomeScreen.isLaunchFirstPage, false);
    }

    return isFirstLaunch;
  }
}

Padding tabbarTitle({required String title}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(title, style: text18),
  );
}
