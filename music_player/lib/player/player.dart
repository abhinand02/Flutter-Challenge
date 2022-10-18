import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_player/Playlist/homeplaylistbutton.dart';
import 'package:music_player/constants/style.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../widgets/player_icons.dart';

class MusicPlayerScreen extends StatefulWidget {
  int index;
   MusicPlayerScreen({super.key,required this.index});

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: appBar(height, context), //appbar
      body: Column(
        children: [
          SongDetails(width: width), //Thumbnail,total time, elapsed time
          const PlayerIcons()
        ], //Icons - play/Pause, next, previous,shuffle, repeat
      ),
    );
  }

  PreferredSize appBar(double height, BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(height / 8),
      child: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          },
          splashRadius: 25,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_outline_rounded),
            onPressed: () {
              

            },
            splashRadius: 20,
          ),
          IconButton(
            icon: const Icon(Icons.playlist_add),
            onPressed: () {
              HomePlaylistButton(songindex: widget.index).playlistBottomSheet(context);
            },
            splashRadius: 20,
          ),
        ],
      ),
    );
  }
}

class SongDetails extends StatefulWidget {
  const SongDetails({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  State<SongDetails> createState() => _SongDetailsState();
}

class _SongDetailsState extends State<SongDetails> {
  final AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');

  @override
  Widget build(BuildContext context) {
    return player.builderCurrent(builder: (context, playing) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: widget.width - 100,
                width: widget.width - 100,
                child: QueryArtworkWidget(
                  id: int.parse(playing.audio.audio.metas.id!),
                  type: ArtworkType.AUDIO,
                  nullArtworkWidget: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.asset(
                        'assets/images/music.png',
                        fit: BoxFit.cover,
                      )),
                ),
              ),
            ],
          ),
          height20,
          Text(
            player.getCurrentAudioTitle,
            style: textWhite22,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          height10,
          Text(
            player.getCurrentAudioArtist,
            style: textgrey14,
          ),
          player.builderCurrentPosition(builder: (context, currentPosition) {
            return Column(
              children: [
                Slider(
                  activeColor: whiteClr,
                  inactiveColor: greyclr,
                  thumbColor: selectedItemColor,
                  value: currentPosition.inSeconds.toDouble(),
                  min: 0.0,
                  max: playing.audio.duration.inSeconds.toDouble(),
                  onChanged: (value) {
                    setState(() {
                      Duration newDuration = Duration(seconds: value.toInt());
                      player.seek(newDuration);
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${currentPosition.toString().split(':')[1]}:${currentPosition.toString().split(':')[2].split('.')[0]}',
                        style: textWhite18,
                      ),
                      Text(
                        '${playing.audio.duration.toString().split(':')[1]}:${playing.audio.duration.toString().split(':')[2].split('.')[0]}',
                        style: textWhite18,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
          height20,
          height20,
        ],
      );
    });
  }
}


// class AddToFav extends StatefulWidget {
//   int index;
//    AddToFav({super.key, required this.index});

//   @override
//   State<AddToFav> createState() => _AddToFavState();
// }

// class _AddToFavState extends State<AddToFav> {
//  List<FavSongs> fav = [];
//  final box = SongBox.getInstance();
//  late  List<Songs> dbSongs;

//   @override
//   void initState() {
//     dbSongs = box.values.toList();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
     
//     return await newMethod();
//   }

//   Future<Icon> newMethod(int index) async {
//     List<FavSongs> fav = [];
//  final box = SongBox.getInstance();
//  late  List<Songs> dbSongs;
//     dbSongs = box.values.toList();
//     fav = favdbsongs.values.toList();
//     fav = favdbsongs.values.toList();
//     return fav.where((element) =>
//                   element.songname == dbSongs[index].songname)
//               .isEmpty
//           ?
//     IconButton(
//         onPressed: () {
          
//             favdbsongs.add(FavSongs(
//                 artist: dbSongs[index].artist,
//                 duration: dbSongs[index].duration,
//                 songname: dbSongs[index].songname,
//                 songurl: dbSongs[index].songurl,
//                 id: dbSongs[index].id));
          
//           // setState(() {});
          
//           print(dbSongs[index].songname);
//           print(favdbsongs.values.toList());

//         },
//         icon: Icon(
//           Icons.favorite_outline_rounded,
//           color: whiteClr,
//         ))
//           :IconButton(
//             onPressed: () async{
                
//          if(favdbsongs.length < 1){
//           favdbsongs.clear();
//           // setState(() {
            
//           // });
//          }else{
//         int currentIndex = fav.indexWhere(
//         (element) => element.id == dbSongs[index].id);

//         await favdbsongs.deleteAt(currentIndex);
//         // setState(() {

//         // });
//          }
    

//     print(index);

//             },
//             icon:  Icon(Icons.favorite_rounded,color: selectedItemColor,)
//           );
//   }
