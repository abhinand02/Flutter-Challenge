import 'package:flutter/material.dart';
import 'package:music_player/Model/db_functions.dart';
import '../constants/style.dart';

AppBar appBar(String title, [IconButton? backButton]) {
  return AppBar(
    leading: backButton,
    title: Text(
      title,
      style: textWhite22,
    ),
    elevation: 0,
    centerTitle: true,
  );
}

Row favPlayListIcons(
    String artist, String songname, String songurl, int duration, int id) {
      // bool favorited = false ;
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Padding(
        padding: const EdgeInsets.only(right: 20, bottom: 20),
        child: IconButton(
          onPressed: () {

            print(id);
            // addFavSongs(FavSongs(
            //     artist: artist,
            //     duration: duration,
            //     songname: songname,
            //     songurl: songurl,
            //     songid: songid,
            //     id: id,),);
          },
          icon: const Icon(Icons.favorite_outline_rounded  ),
          // color: favorited == false ? whiteClr : selectedItemColor,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 10, bottom: 20),
        child: Icon(
          Icons.playlist_add,
          color: whiteClr,
        ),
      )
    ],
  );
}
