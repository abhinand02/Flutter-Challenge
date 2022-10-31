import 'dart:async';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_player/Model/db_functions.dart';
import 'package:music_player/Model/model.dart';
import 'package:music_player/Model/mostplayed_model.dart';
import 'package:music_player/widgets/bottom_navbar.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../Home/artist_screen.dart';

late bool status;

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
    // sharedPreferece();
    requestStoragePremission();
    getArtist();
    super.initState();
  }

  Timer goToHome() {
    return Timer(
      const Duration(seconds: 2),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (BuildContext context) => const BottomNavBar()),
      ),
    );
  }

  void requestStoragePremission() async {
    bool permissionStatus = await audioPlayer.permissionsStatus();
 status = permissionStatus;
    if (!permissionStatus) {
      await audioPlayer.permissionsRequest();
       goToHome();
      fetchallSongs = await audioPlayer.querySongs(
        orderType: OrderType.ASC_OR_SMALLER,
      );

      for (var element in fetchallSongs) {
        if (element.fileExtension == "mp3") {
          allSongs.add(element);
        }
      }

      for (var element in allSongs) {
        box.add(Songs(
            songname: element.title,
            artist: element.artist!,
            duration: element.duration!,
            songurl: element.uri!,
            // favorite: false,
            id: element.id));
      }

      for (var element in allSongs) {
        mostplayedsongs.add(MostPlayed(
            songname: element.title,
            songurl: element.uri!,
            duration: element.duration!,
            artist: element.artist!,
            count: 0,
            id: element.id),);
      }
    }else{
      goToHome();
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
