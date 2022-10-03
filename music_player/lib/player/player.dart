import 'package:flutter/material.dart';
import 'package:music_player/constants/style.dart';

class MusicPlayerScreen extends StatelessWidget {
  const MusicPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appBar(height,context),                                        //appbar 
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SongDetails(width: width),                                //Thumbnail,total time, elapsed time
          const PlayerIcons()],                                     //Icons - play/Pause, next, previous,shuffle, repeat
      ),
    );
  }

  PreferredSize appBar(double height, BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(height / 8),
      child: AppBar(
        elevation: 0,
        leading:  IconButton(icon:const Icon(Icons.arrow_back_ios_new_rounded),onPressed: (){
          Navigator.of(context).pop();
        },splashRadius: 25,),
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

class SongDetails extends StatelessWidget {
  const SongDetails({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: width - 100,
              width: width - 100,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: const Image(
                      image: AssetImage('assets/images/Frame 38.png'))),
            ),
          ],
        ),
        height20,
        Text(
          'Edhir Neechal Adi',
          style: textWhite22,
        ),
        Text(
          'Anirudh Musical',
          style: textgrey14,
        ),
        Slider(
            activeColor: whiteClr,
            inactiveColor: greyclr,
            value: .4,
            onChanged: (value) {}),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '01:20',
                style: textWhite18,
              ),
              Text('02:50', style: textWhite18),
            ],
          ),
        ),
        height20,
        height20,
      ],
    );
  }
}

class PlayerIcons extends StatelessWidget {
  const PlayerIcons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: const Icon(Icons.shuffle_rounded),
          iconSize: 30,
          color: greyclr,
          onPressed: () {},
          padding: EdgeInsets.zero,
          splashRadius: 30,
        ),
        IconButton(
          icon: const Icon(Icons.skip_previous_sharp),
          iconSize: 40,
          color: greyclr,
          onPressed: () {},
          padding: EdgeInsets.zero,
          splashRadius: 30,
        ),
        IconButton(
          icon: const Icon(Icons.play_circle_filled_outlined),
          color: selectedItemColor,
          iconSize: 80,
          onPressed: () {},
          padding: EdgeInsets.zero,
          splashRadius: 40,
        ),
        IconButton(
          icon: const Icon(Icons.skip_next_sharp),
          color: greyclr,
          iconSize: 40,
          onPressed: () {},
          padding: EdgeInsets.zero,
          splashRadius: 30,
        ),
        IconButton(
          icon: const Icon(Icons.repeat_outlined),
          color: greyclr,
          iconSize: 30,
          onPressed: () {},
          padding: EdgeInsets.zero,
          splashRadius: 30,
        ),
      ],
    );
  }
}
