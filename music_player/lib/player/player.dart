import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_player/constants/style.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../widgets/player_icons.dart';

class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({super.key});

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appBar(height, context), //appbar
      body: Column(
        children: [
          SongDetails(width: width), //Thumbnail,total time, elapsed time
          const PlayerIcons()
        ], //Icons - play/Pause, next, previous,shuffle, repeat
      ),
    );
  }

  PreferredSize appBar(double height, BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(height / 8),
      child: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          },
          splashRadius: 25,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_outline_rounded),
            onPressed: () {},
            splashRadius: 20,
          ),
          IconButton(
            icon: const Icon(Icons.playlist_add),
            onPressed: () {},
            splashRadius: 20,
          ),
        ],
      ),
    );
  }
}

class SongDetails extends StatefulWidget {

  const SongDetails({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  State<SongDetails> createState() => _SongDetailsState();
}

class _SongDetailsState extends State<SongDetails> {
  final AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');
 late Duration playertime; 

  @override
  Widget build(BuildContext context) {
    return player.builderCurrent(builder: (context, playing) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: widget.width - 100,
                width: widget.width - 100,
                child: QueryArtworkWidget(
                  id: int.parse(playing.audio.audio.metas.id!), type: ArtworkType.AUDIO,
                  nullArtworkWidget: ClipRRect(borderRadius: BorderRadius.circular(40),
                    child: Image.asset('assets/images/music.png',fit: BoxFit.cover,)),
                  ),
              ),
            ],
          ),
          height20,
          Text(
            player.getCurrentAudioTitle,
            style: textWhite22,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          height10,
          Text(
            player.getCurrentAudioArtist,
            style: textgrey14,
          ),
          player.builderCurrentPosition(builder: (context, currentPosition){
            return Slider(
              activeColor: whiteClr,
              inactiveColor: greyclr,
              thumbColor: selectedItemColor,
              value: currentPosition.inSeconds.toDouble(),
              min: 0.0,
              max: playing.audio.duration.inSeconds.toDouble(),
              onChanged: (value) {
                setState(() {
                  Duration newDuration = Duration(seconds: value.toInt());
                  player.seek(newDuration);
                });
              },
              );
          }),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                   ((playing.audio.duration.inSeconds)/60).toStringAsFixed(2),
                  style: textWhite18,
                ),
                Text(((playing.audio.duration.inSeconds)/60).toStringAsFixed(2), style: textWhite18,),
              ],
            ),
          ),
          height20,
          height20,
        ],
      );
    });
  }
}