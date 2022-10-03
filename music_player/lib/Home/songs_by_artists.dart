import 'package:flutter/material.dart';
import 'package:music_player/constants/style.dart';
import 'package:music_player/widgets/method.dart';

class SongsByArtistScreen extends StatelessWidget {
  const SongsByArtistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height / 2.5),
        child: Stack(
          children: [
            SizedBox(
              width: width,
              child: const ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                child: Image(
                  image: AssetImage('assets/images/Frame 38.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 20,
              child: Text(
                'Amir Tataloo',
                style: TextStyle(
                    fontSize: 30, fontWeight: FontWeight.bold, color: whiteClr),
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: 10),
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Image(
                image: AssetImage('assets/images/music-removebg.png')),
            title: Text(
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
    );
  }
}
