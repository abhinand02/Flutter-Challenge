import 'package:flutter/material.dart';
import '../constants/style.dart';
import 'songs_by_artists.dart';

class Artist extends StatelessWidget {
  const Artist({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: ((ctx1, index) {
              return artistListTile(context);
            }),
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 10,
              );
            },
            itemCount: 5,
          ),
        )
      ],
    );
  }

  Row artistListTile(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const SongsByArtistScreen();
                }));
              },
              child: Container(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                width: width / 2.7,
                height: width / 2.3,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: const Image(
                      image: AssetImage('assets/images/music.png'),
                      fit: BoxFit.cover,
                    )),
              ),
            ),
            Text(
              'Artist Name',
              style: textWhite18,
            ),
            Text(
              'No. of Songs',
              style: textgrey18,
            )
          ],
        ),
        Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const SongsByArtistScreen();
                }));
              },
              child: Container(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                width: width / 2.7,
                height: width / 2.3,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: const Image(
                      image: AssetImage('assets/images/music.png'),
                      fit: BoxFit.cover,
                    )),
              ),
            ),
            Text(
              'Artist Name',
              style: textWhite18,
            ),
            Text(
              'No. of Songs',
              style: textgrey18,
            )
          ],
        ),
      ],
    );
  }
}
