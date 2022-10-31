import 'dart:async';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/style.dart';

AssetsAudioPlayer audioplayer = AssetsAudioPlayer();

AppBar appBar(String title, [IconButton? backButton, IconButton? trailingButton]) {
  return AppBar(
    leading: backButton,
    title: Text(
      title,
      style: textWhite22,
    ),
    elevation: 0,
    centerTitle: true,
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: trailingButton,
      )
    ],
  );
}

sleeptime(int picktime) {
  Timer(Duration(seconds: picktime), popFunction);
}

popFunction() {
  SystemNavigator.pop();
}
