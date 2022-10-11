import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_player/Home/home_screen.dart';
import 'package:music_player/constants/style.dart';
import 'package:music_player/player/player.dart';
import 'package:on_audio_query/on_audio_query.dart';

bool isPlaying = false;

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({super.key});

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');
  @override
  Widget build(BuildContext context) {
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
                    return const MusicPlayerScreen();
                  },
                ),
              );
            }
          },
          child: Container(
            color: miniPlayerclr,
            width: double.infinity,
            height: 70,
            child: Column(
              children: [
                ListTile(
                  leading: QueryArtworkWidget(
                    id: int.parse(playing.audio.audio.metas.id!), // image
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
        );
      },
    );
  }
}
