import 'package:flutter/material.dart';
import 'package:music_player/Home/mostly_played_screen.dart';
import 'package:music_player/Home/recently_played_screen.dart';
import 'package:music_player/constants/style.dart';
import '../widgets/method.dart';
import '../widgets/mini_player.dart';
import 'artist_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(height / 5),
          child: appBar(height),
        ),
        body: TabBarView(physics: const BouncingScrollPhysics(), children: [
          ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Image(
                    image: AssetImage('assets/images/music-removebg.png')),
                title:
                 Text(
                    'Strangers By Nature',
                    style: textWhite18,
                  ),
                subtitle: Text(
                  'Adele',
                  style: TextStyle(color: unSelectedItemClr),
                ),
                trailing: favPlayListIcons(),
              );
            },
            itemCount: 10,
          ),
          Artist(width: width),
          const RecentlyPlayedScreen(),
          const MostlyPlayedScreen(),
        ]),
        bottomSheet: const MiniPlayer(),
      ),
    );
  }

  AppBar appBar(double height) {
    return AppBar(
      elevation: 1,
      backgroundColor: backGroundColor,
      toolbarHeight: height * .5,
      leadingWidth: height * .2,
      leading: const Image(
        image: AssetImage('assets/images/music-removebg.png'),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 20),
          child: Icon(Icons.search),
        ),
      ],
      bottom: TabBar(
        physics: const BouncingScrollPhysics(),
        isScrollable: true,
        indicatorWeight: 4,
        indicatorColor: selectedItemColor,
        labelColor: selectedItemColor,
        unselectedLabelColor: unSelectedItemClr,
        tabs: [
          tabbarTitle(title: 'Songs'),
          tabbarTitle(title: 'Artist'),
          tabbarTitle(title: 'Recently Played'),
          tabbarTitle(title: 'Mostly Played'),
        ],
      ),
    );
  }
}

Padding tabbarTitle({required String title}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(title, style: text18),
  );
}
