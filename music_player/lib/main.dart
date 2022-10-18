import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/Model/db_functions.dart';
import 'package:music_player/Model/favmodel.dart';
import 'package:music_player/Model/model.dart';
import 'package:music_player/Model/mostplayed_model.dart';
import 'package:music_player/Model/playlistmodel.dart';
import 'package:music_player/Model/recentsong_model.dart';
import 'package:music_player/constants/style.dart';
import 'Splash Screen/splashscreen.dart';

Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(SongsAdapter());
  await Hive.openBox<Songs>('Songs');

  Hive.registerAdapter(PlaylistSongsAdapter());
  openDatabase();

  Hive.registerAdapter(FavSongsAdapter());
  openfavdb();

  Hive.registerAdapter(MostPlayedAdapter());
  openmostplayeddb();

  Hive.registerAdapter(RecentPlayedAdapter());
  openrecentlyplayedDb();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: GoogleFonts.urbanistTextTheme(Theme.of(context).textTheme,),
        appBarTheme: AppBarTheme(backgroundColor: backGroundColor),
        sliderTheme: const SliderThemeData(trackHeight: 2),
      scaffoldBackgroundColor: backGroundColor),
      home: const SplashScreen(
      ),
    );
  }
}