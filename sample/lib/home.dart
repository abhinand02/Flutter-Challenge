import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:sample/Open%20Player/open_player.dart';
import 'package:sample/main.dart';
import 'package:sample/model/model.dart';

class Player extends StatefulWidget {
  const Player({super.key});

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  final box = SongBox.getInstance();

  List<Audio> convertAudios = [];
  List<SongModel> fetchSongs = [];
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
  List<SongModel> allSongList = [];
  final OnAudioQuery _audioQuery = OnAudioQuery();
  bool isLoading = true;

  @override
  void initState() {
    // box.clear();
    // fetchSong();
    List<Songs> dbsongs = box.values.toList();

    for (var item in dbsongs) {
      convertAudios.add(Audio.file(item.songurl!,
          metas: Metas(
              title: item.songname,
              artist: item.artist,
              id: item.id.toString())));
    }
    requestStoragePermission();
    super.initState();
    getAllSongList();
  }

  Future<void> getAllSongList() async {
    allSongList = await _audioQuery.querySongs();
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions:  [
        IconButton(onPressed: (){
          final themeProvider = Provider.of<ThemeProvider>(context,listen: false);

          setState(() {
            isDark = !isDark;
          });

          isDark ? themeProvider.setDarkMode() 
          : themeProvider.setLightMode();
        }, icon: const Icon(Icons.dark_mode_rounded))
      ],),
      body: ValueListenableBuilder<Box<Songs>>(
          valueListenable: box.listenable(),
          builder: (context, Box<Songs> allSongs, child) {
            List<Songs> allDbSongs = allSongs.values.toList();

            if (allDbSongs.isEmpty) {
              return const Center(
                child: Text('No Songs Found'),
              );
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                Songs songs = allDbSongs[index];

                return ListTile(
                  onTap: () async {
                    await OpenPlayer(
                      allsongs: convertAudios,
                      index: index,
                    ).openAssetPlayer(
                      index: index,
                      songs: convertAudios,
                    );

                    // print('HEEEEEEEEEEEEEEEEEEEE');
                    // print(convertAudios);
                  },
                  leading: QueryArtworkWidget(
                    artworkBorder: BorderRadius.zero,
                    id: songs.id!,
                    type: ArtworkType.AUDIO,
                    artworkFit: BoxFit.cover,
                  ),
                  title: Text(songs.artist!),
                  subtitle: Text(songs.artist!),
                );
              },
              itemCount: allDbSongs.length,
            );
          }),
    );
  }

  void requestStoragePermission() async {
    //only if the platform is not web, coz web have no permissions
    if (!kIsWeb) {
      bool permissionStatus = await _audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await _audioQuery.permissionsRequest();

        fetchSongs = await _audioQuery.querySongs();

        for (var element in fetchSongs) {
          if (element.fileExtension == "mp3") {
            allSongList.add(element);
          }
        }
        allSongList.forEach((element) {
          box.add(Songs(
              songname: element.title,
              artist: element.artist,
              duration: element.duration,
              songurl: element.uri,
              id: element.id));
        });
      }

      //ensure build method is called
      setState(() {});
    }
  }

  fetchSong() async {
    fetchSongs = await _audioQuery.querySongs();

    for (var element in fetchSongs) {
      if (element.fileExtension == "mp3") {
        allSongList.add(element);
      }
    }

    allSongList.forEach((element) {
      box.add(Songs(
          songname: element.title,
          artist: element.artist,
          duration: element.duration,
          songurl: element.uri,
          id: element.id));
    });
  }
}


//  Duration _duration = Duration();
//   Duration _position = Duration();
//   bool isPlaying = false;
//   bool isPaused = false;
//   bool isLoop = false;
// import 'package:flutter/material.dart';
// import 'package:on_audio_query/on_audio_query.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'FlutterPlay Songs',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'FlutterPlay Songs'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//   final String title;
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   // bg color
//   Color bgColor = Colors.brown;

//   //define on audio plugin
//   final OnAudioQuery _audioQuery = OnAudioQuery();

//   //request permission from initStateMethod
//   @override
//   void initState() {
//     super.initState();
//     requestStoragePermission();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//         //backgroundColor: bgColor,
//         elevation: 20,
//         backgroundColor: bgColor,
//       ),
//     backgroundColor: bgColor,
//       body: FutureBuilder<List<SongModel>>(
//         //default values
//         future: _audioQuery.querySongs(
//           orderType: OrderType.ASC_OR_SMALLER,
//           uriType: UriType.EXTERNAL,
//           ignoreCase: true,
//         ),
//         builder: (context, item){
//           //loading content indicator
//           if(item.data == null){
//             return const Center(child: CircularProgressIndicator(),);
//           }
//           //no songs found
//           if(item.data!.isEmpty){
//             return const Center(child: Text("No Songs Found"),);
//           }

//           // You can use [item.data!] direct or you can create a list of songs as
//           // List<SongModel> songs = item.data!;
//           //showing the songs
//           return ListView.builder(
//             itemCount: item.data!.length,
//             itemBuilder: (context, index){

//               return Container(
//                 margin: const EdgeInsets.only(top: 15.0, left: 12.0, right: 16.0),
//                 padding: const EdgeInsets.only(top: 30.0, bottom: 30),
//                 decoration: BoxDecoration(
//                   color: bgColor,
//                   borderRadius: BorderRadius.circular(20.0),
//                   boxShadow: const[
//                     BoxShadow(
//                       blurRadius: 4.0,
//                       offset: Offset(-4, -4),
//                       color: Colors.white24,
//                     ),
//                     BoxShadow(
//                       blurRadius: 4.0,
//                       offset: Offset(4, 4),
//                       color: Colors.black,
//                     ),
//                   ],
//                 ),
//                 child:ListTile(
//                   textColor: Colors.white,
//                   title: Text(item.data![index].title),
//                   subtitle: Text(item.data![index].displayName,
//                     style: const TextStyle(
//                       color: Colors.white60,
//                     ),
//                   ),
//                   trailing: const Icon(Icons.more_vert),
//                   leading: QueryArtworkWidget(
//                     id: item.data![index].id,
//                     type: ArtworkType.AUDIO,

//                   ),
//                   onTap: ()  {
//                     //toast message showing he selected song title
//                       toast(context, "You Selected:   " + item.data![index].title);
                   
//                   },
//                 ),
//               );

//             });
//         },
//       ),
//     );
//   }
//   //define a toast method
//   void toast(BuildContext context, String text){
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(text),
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
//     ));
//   }

//   void requestStoragePermission() async {
//     //only if the platform is not web, coz web have no permissions
//     if(!kIsWeb){
//       bool permissionStatus = await _audioQuery.permissionsStatus();
//       if(!permissionStatus){
//         await _audioQuery.permissionsRequest();
//       }

//       //ensure build method is called
//       setState(() { });
//     }
//   }

// }