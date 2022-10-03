import 'package:flutter/material.dart';
import 'package:music_player/constants/style.dart';
import 'package:music_player/player/player.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({super.key});

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

bool playing = true;

class _MiniPlayerState extends State<MiniPlayer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return const MusicPlayerScreen();
              },
            ),
          );
        }
      },
      child: Container(
        color: miniPlayerclr,
        width: double.infinity,
        height: 70,
        child: Column(
          children: [
            ListTile(
              leading: Container(
                width: 70,
                height: 75,
                margin: const EdgeInsets.only(top: 5),
                child: const Image(
                  image: AssetImage('assets/images/music.png'),
                  fit: BoxFit.cover,
                ),
              ),
              trailing: IconButton(
                icon: playing
                    ? const Icon(
                        Icons.pause,
                      )
                    : const Icon(
                        Icons.play_arrow_rounded,
                      ),
                color: selectedItemColor,
                iconSize: 35,
                onPressed: () {
                  setState(() {
                    if (playing == true) {
                      playing = false;
                    } else {
                      playing = true;
                    }
                  });
                },
              ),
              title: Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Text(
                    'Edhir Neechal Adi',
                    style: TextStyle(color: whiteClr),
                  )),
              subtitle: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Text(
                  'Anirudh Musical',
                  style: TextStyle(color: greyclr),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
