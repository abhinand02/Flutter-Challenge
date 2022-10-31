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
import 'package:shared_preferences/shared_preferences.dart';
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
      providers: [ChangeNotifierProvider(create: (_) => ThemeProvider())],
      child: const MyApp()));
}
  bool isDarkMode = true;
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
  sharedPreferece();
    super.initState();
  }
  sharedPreferece() async{
  final sharedpref = await SharedPreferences.getInstance();
   final isDark = sharedpref.getBool('isDarkMode');
  isDarkMode = isDark!;
  print(isDarkMode);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkMode? Provider.of<ThemeProvider>(context).currentTheme ?? ThemeData(
      fontFamily: 'Urbanist',
      appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(color: whiteClr),
        iconTheme: IconThemeData(color: whiteClr),
          backgroundColor: backGroundColor,
          toolbarTextStyle: TextStyle(color: whiteClr)),
      textTheme: Theme.of(context).textTheme.apply(bodyColor: whiteClr,),
      sliderTheme: const SliderThemeData(trackHeight: 2),
      listTileTheme: ListTileThemeData(
        iconColor: whiteClr,
      ),
      scaffoldBackgroundColor: backGroundColor,
      iconTheme: IconThemeData(color: whiteClr),
    ): Provider.of<ThemeProvider>(context).currentTheme ?? ThemeData(
      scaffoldBackgroundColor: whiteClr,
      iconTheme: IconThemeData(color: blackClr),
      listTileTheme: ListTileThemeData(
        iconColor: blackClr,
      ),
      appBarTheme: AppBarTheme(
          backgroundColor: whiteClr,
          iconTheme: IconThemeData(color: blackClr),
          titleTextStyle: TextStyle(color: blackClr),
          toolbarTextStyle: TextStyle(color: blackClr),),
      textTheme: Theme.of(context).textTheme.apply(bodyColor: blackClr,),
      sliderTheme: const SliderThemeData(trackHeight: 2),
      fontFamily: 'Urbanist',
    ),
      home: const SplashScreen(),
    );
  }
}

class ThemeProvider extends ChangeNotifier {
  ThemeData? currentTheme;

  setDarkMode(BuildContext context) {
    currentTheme =  ThemeData(
      fontFamily: 'Urbanist',
      appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(color: whiteClr),
        iconTheme: IconThemeData(color: whiteClr),
          backgroundColor: backGroundColor,
          toolbarTextStyle: TextStyle(color: whiteClr)),
      textTheme: Theme.of(context).textTheme.apply(bodyColor: whiteClr,),
      sliderTheme: const SliderThemeData(trackHeight: 2),
      listTileTheme: ListTileThemeData(
        iconColor: whiteClr,
      ),
      scaffoldBackgroundColor: backGroundColor,
      iconTheme: IconThemeData(color: whiteClr),
    );
    notifyListeners();
  }

  setLightMode(BuildContext context) {
    currentTheme = ThemeData(
      scaffoldBackgroundColor: whiteClr,
      iconTheme: IconThemeData(color: blackClr),
      listTileTheme: ListTileThemeData(
        iconColor: blackClr,
      ),
      appBarTheme: AppBarTheme(
          backgroundColor: whiteClr,
          iconTheme: IconThemeData(color: blackClr),
          titleTextStyle: TextStyle(color: blackClr),
          toolbarTextStyle: TextStyle(color: blackClr),),
      textTheme: Theme.of(context).textTheme.apply(bodyColor: blackClr,),
      sliderTheme: const SliderThemeData(trackHeight: 2),
      fontFamily: 'Urbanist',
    );
    notifyListeners();
  }
}
