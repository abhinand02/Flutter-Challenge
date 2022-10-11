import 'dart:async';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_player/Model/model.dart';
import 'package:music_player/widgets/bottom_navbar.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

final audioPlayer = OnAudioQuery();
final box = SongBox.getInstance();

List<SongModel> fetchallSongs = [];
List<SongModel> allSongs = [];
List<Audio> songsList = [];

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    requestStoragePremission();
    goToHome();
    super.initState();
  }

  Timer goToHome() {
    return Timer(
      const Duration(seconds: 3),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (BuildContext context) => const BottomNavBar()),
      ),
    );
  }

  void requestStoragePremission() async {
    bool permissionStatus = await audioPlayer.permissionsStatus();

    if (!permissionStatus) {
      await audioPlayer.permissionsRequest();

      fetchallSongs = await audioPlayer.querySongs(
          orderType: OrderType.ASC_OR_SMALLER,);

      for (var element in fetchallSongs) {
        if (element.fileExtension == "mp3") {
          allSongs.add(element);
        }
      }

      for(var element in allSongs) {
        box.add(Songs(
            songname: element.title,
            artist: element.artist!,
            duration: element.duration!,
            songurl: element.uri!,
            id: element.id));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Image(
          image: const AssetImage('assets/images/music-removebg.png'),
          width: width * .6,
        ),
      ),
    );
  }
}
