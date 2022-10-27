import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/Model/db_functions.dart';
import 'package:music_player/Model/favmodel.dart';
import 'package:music_player/Model/model.dart';
import 'package:music_player/Model/mostplayed_model.dart';
import 'package:music_player/Model/playlistmodel.dart';
import 'package:music_player/Model/recentsong_model.dart';
import 'package:music_player/constants/style.dart';
import 'package:provider/provider.dart';
import 'Splash Screen/splashscreen.dart';

Future<void> main() async {
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

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_)=> ThemeProvider())
    ],
    child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).currentTheme,
      home: const SplashScreen(),
    );
  }
}

  bool isDarkMode = true;
class ThemeProvider extends ChangeNotifier{
  ThemeData currentTheme = ThemeData(
          fontFamily: 'Urbanist',
          // textTheme: Theme.of(context).textTheme.apply(bodyColor: whiteClr),
          appBarTheme: AppBarTheme(backgroundColor: backGroundColor),
          sliderTheme: const SliderThemeData(trackHeight: 2),
          scaffoldBackgroundColor: backGroundColor);

  setDarkMode(BuildContext context){
     currentTheme = ThemeData(
      fontFamily: 'Urbanist',
          appBarTheme: AppBarTheme(backgroundColor: backGroundColor),
          sliderTheme: const SliderThemeData(trackHeight: 2),
          scaffoldBackgroundColor: backGroundColor,
          textTheme: Theme.of(context).textTheme.apply(bodyColor: whiteClr)
     );
     notifyListeners();
  }

  setLightMode(BuildContext context){
    currentTheme = ThemeData(scaffoldBackgroundColor: whiteClr,
    appBarTheme: AppBarTheme(backgroundColor: whiteClr),
    fontFamily: 'Urbanist',
    // textTheme: Theme.of(context).textTheme.apply(bodyColor: blackClr)
    );
    notifyListeners();
  }
}