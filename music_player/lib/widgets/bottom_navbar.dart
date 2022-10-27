import 'package:flutter/material.dart';
import 'package:music_player/Favourite/favourite.dart';
import 'package:music_player/Home/home_screen.dart';
import 'package:music_player/Playlist/playlist.dart';
import 'package:music_player/settings/settings.dart';
import '../constants/style.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;
  final _pages = const [
    HomeScreen(),
    FavoriteScreen(),
    PlaylistScreen(),
    SettingsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: backGroundColor,
        selectedItemColor: selectedItemColor,
        unselectedItemColor: unSelectedItemClr,
        selectedFontSize: 14,
        unselectedFontSize: 13,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_rounded), label: 'Favourite'),
          BottomNavigationBarItem(
              icon: Icon(Icons.queue_music_sharp), label: 'Playlist'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings')
        ],
        onTap: (value) {
          setState(
            () {
              currentIndex = value;
            },
          );
        },
      ),
    );
  }
}
