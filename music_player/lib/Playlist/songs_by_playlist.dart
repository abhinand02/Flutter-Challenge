import 'package:flutter/material.dart';
import 'package:music_player/widgets/method.dart';
import '../constants/style.dart';

class SongsByPlaylistScreen extends StatelessWidget {
  const SongsByPlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Playlist1', IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back_ios_new_rounded),splashRadius: 25,),),
      body: ListView.builder(
            physics: const BouncingScrollPhysics(),
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
                trailing: Padding(
                  padding: const EdgeInsets.only(bottom: 20,right: 10),
                  child: Icon(Icons.remove_outlined,color: whiteClr,),
                ),   
              );
            },
            itemCount: 10,
          ),
    );
  }
}