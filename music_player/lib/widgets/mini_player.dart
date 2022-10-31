import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_player/Home/home_screen.dart';
import 'package:music_player/constants/style.dart';
import 'package:music_player/NowPlaying%20Screen/nowplaying.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

bool isPlaying = false;

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({super.key});

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');
  GlobalKey _one = GlobalKey();
  late BuildContext myContext;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isFirstLaunch().then((result) {
        if (result) {
          ShowCaseWidget.of(myContext).startShowCase([_one]);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      builder: Builder(
        builder: (context) {
          myContext = context;
          return player.builderCurrent(
            builder: (context, playing) {
              return GestureDetector(
                onHorizontalDragEnd: (DragEndDetails details) {
                  if (details.primaryVelocity! > 0) {
                    player.previous();
                  } else if (details.primaryVelocity! < 0) {
                    player.next();
                  }
                },
                onTap: () {
                  {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return NowPlayingScreen(
                          );
                        },
                      ),
                    );
                  }
                },
                child: Showcase(
                  key: _one,
                  title: "Guide",
                  titleTextStyle: textBlack22,
                  descTextStyle: text18,
                  description:
                      "Hi User,  \nyou can Swipe Right here for the Next Song \nand Swipe Left For Previous Song !.",
                  child: Container(
                    color: miniPlayerclr,
                    width: double.infinity,
                    height: 70,
                    child: Column(
                      children: [
                        ListTile(
                          leading: QueryArtworkWidget(
                            id: int.parse(
                                playing.audio.audio.metas.id!), // image
                            type: ArtworkType.AUDIO,
                            artworkFit: BoxFit.fill,
                            artworkHeight: 75,
                            artworkWidth: 60,
                            artworkBorder: BorderRadius.circular(15),
                            nullArtworkWidget: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(
                                  'assets/images/music.png',
                                  fit: BoxFit.cover,
                                  width: 65,
                                  height: 75,
                                )),
                          ),
                          trailing: PlayerBuilder.isPlaying(
                              // Play/Pause button
                              player: player,
                              builder: (context, isPlaying) {
                                return IconButton(
                                  icon: Icon(isPlaying
                                      ? Icons.pause_rounded
                                      : Icons.play_arrow_rounded),
                                  color: selectedItemColor,
                                  iconSize: 35,
                                  onPressed: () {
                                    player.playOrPause();
                                  },
                                  padding: EdgeInsets.zero,
                                  splashRadius: 40,
                                );
                              }),
                          title: Container(
                              // title
                              margin: const EdgeInsets.only(top: 10),
                              child: Text(
                                player.getCurrentAudioTitle,
                                style: TextStyle(
                                  color: whiteClr,
                                ),
                                overflow: TextOverflow.ellipsis,
                              )),
                          subtitle: Padding(
                            //artist
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Text(
                              player.getCurrentAudioArtist,
                              style: TextStyle(color: greyclr),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

Future<bool> _isFirstLaunch() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  bool isFirstLaunch =
      sharedPreferences.getBool(HomeScreen.isFirstPageLaunch) ?? true;

  if (isFirstLaunch) {
    sharedPreferences.setBool(HomeScreen.isFirstPageLaunch, false);
  }

  return isFirstLaunch;
}
