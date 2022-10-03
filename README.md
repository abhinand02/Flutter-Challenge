This is a flutter challenge. i am started with some dart basics (The programs folder containing some dart basic core programs) then came to flutter basics. I completed some sample works.

1. Login page and Home Page With shared Preference.
2. Student Records App
         # This app for storing Student details Locally.DB used for this app is Hive.
import 'package:flutter/material.dart';
import 'package:music_player/constants/style.dart';

class MusicPlayerScreen extends StatelessWidget {
  const MusicPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height / 8),
        child: AppBar(
          elevation: 0,
          leading: const Icon(Icons.arrow_back_ios),
          actions: const [
            Icon(Icons.favorite_outline_rounded),
            Padding(padding: EdgeInsets.all(10)),
            Icon(Icons.playlist_add),
            Padding(padding: EdgeInsets.all(10)),
          ],
        ),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                width: width - 100,
                height: width - 100,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: const Image(
                      image: AssetImage('assets/images/Frame 38.png'),
                      fit: BoxFit.cover,
                    ),),
              ),
            ],
          ),
          height20, 
          Text('Edhir Neechal Adi',style: textWhite22,),
          height10,
          Text('Anirudh Musical',style: textgrey14,)
        ],
      ),
    );
  }
}