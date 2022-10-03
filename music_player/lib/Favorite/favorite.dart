import 'package:flutter/material.dart';
import 'package:music_player/constants/style.dart';
import 'package:music_player/player/player.dart';
import 'package:music_player/widgets/method.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Favorites'),
        body: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return const MusicPlayerScreen();
                  }));
                },
                leading: const Image(
                    image: AssetImage('assets/images/music-removebg.png')),
                title: Text(
                  'Strangers By Nature',
                  style: textWhite18,
                ),
                trailing: IconButton(icon: const Icon(Icons.favorite_rounded),onPressed: (){},color: selectedItemColor,),
              );
            },
            itemCount: 2,
          ),
    );
  }
}

