import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'home.dart';
import 'model/model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(SongsAdapter());
  await Hive.openBox<Songs>('Songs');

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
    )
  ], child: const MyApp()));
}

class ThemeProvider extends ChangeNotifier {
  ThemeData? currentTheme;

  setLightMode() {
    currentTheme = ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.red,
    );
    notifyListeners();
  }

  setDarkMode() {
    currentTheme = ThemeData(
        brightness: Brightness.dark,
         scaffoldBackgroundColor: Colors.green,
         );
         notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: Provider.of<ThemeProvider>(context).currentTheme,
      home: const Player(),
    );
  }
}
