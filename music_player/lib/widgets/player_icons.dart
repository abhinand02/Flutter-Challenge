import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_player/Splash%20Screen/splashscreen.dart';
import 'package:music_player/constants/style.dart';
import '../Model/model.dart';

  bool isRepeat = false; 
  bool isShuffle = false;

class PlayerIcons extends StatefulWidget {
  const PlayerIcons({
    Key? key,
  }) : super(key: key);
  

  @override
  State<PlayerIcons> createState() => _PlayerIconsState();
}

class _PlayerIconsState extends State<PlayerIcons> {
  final AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');
  List<Songs> dbSongs = box.values.toList();


  @override
  Widget build(BuildContext context) {
    return player.builderCurrent(builder: (context, playing) {
      return Builder(builder: (context) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: isShuffle ? Icon(Icons.shuffle_rounded,color: selectedItemColor,) : const Icon(Icons.shuffle_rounded) ,
              iconSize: 30,
              color: greyclr,
              onPressed: () {
                setState(() {
                  if(isShuffle == true){
                    isShuffle = false;
                    player.toggleShuffle();
                  }else{
                    isShuffle = true;
                    player.toggleShuffle();
                  }
                });
              },
              padding: EdgeInsets.zero,
              splashRadius: 30,
            ),
            IconButton(
              icon: const Icon(Icons.skip_previous_sharp),
              iconSize: 40,
              color: greyclr,
              onPressed: () {
                player.previous();
              },
              padding: EdgeInsets.zero,
              splashRadius: 30,
            ),
            PlayerBuilder.isPlaying(
                player: player,
                builder: (context, isPlaying) {
                  return IconButton(
                    icon: Icon(isPlaying
                        ? Icons.pause_circle_filled_rounded
                        : Icons.play_circle_filled_outlined),
                    color: selectedItemColor,
                    iconSize: 80,
                    onPressed: () {
                      player.playOrPause();
                    },
                    padding: EdgeInsets.zero,
                    splashRadius: 40,
                  );
                }),
            IconButton(
              icon: const Icon(Icons.skip_next_sharp),
              color: greyclr,
              iconSize: 40,
              onPressed: playing.index == (dbSongs.length - 1)
                  ? () {}
                  : () {
                      player.next();

                      // print('${dbSongs.length} last index ');
                    },
              padding: EdgeInsets.zero,
              splashRadius: 30,
            ),
            IconButton(
              icon: isRepeat == true
                  ? Icon(Icons.repeat_one_rounded,color: selectedItemColor,)
                  : const Icon(Icons.repeat_outlined),
              color: greyclr,
              iconSize: 30,
              onPressed: () {
                setState(() {
                  if (isRepeat == false) {
                    isRepeat = true;
                    player.setLoopMode(LoopMode.single);
                  } else {
                    isRepeat = false;
                    player.setLoopMode(LoopMode.none);
                  }
                });
              },
              padding: EdgeInsets.zero,
              splashRadius: 30,
            ),
          ],
        );
      });
    });
  }
}
