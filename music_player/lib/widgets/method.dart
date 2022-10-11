import 'package:flutter/material.dart';
import '../constants/style.dart';


AppBar appBar( String title,[IconButton? backButton]) {
    return AppBar(
      leading: backButton,
      title:  Text(title,style: textWhite22,),
      elevation: 0,
      centerTitle: true,
      );
  }

    Row favPlayListIcons() {
    return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20,bottom: 20),
                  child: Icon(
                    Icons.favorite_outline_rounded,
                    color: whiteClr,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10,bottom: 20),
                  child: Icon(
                    Icons.playlist_add,
                    color: whiteClr,
                  ),
                )
              ],
              );
  }

