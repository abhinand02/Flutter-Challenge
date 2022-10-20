import 'package:flutter/material.dart';

import '../Model/db_functions.dart';
import '../Model/favmodel.dart';
import '../Model/model.dart';
import '../Playlist/homeplaylistbutton.dart';
import '../constants/style.dart';

class FavIcons extends StatefulWidget {
  int index;

  FavIcons(
      {Key? key,
      required this.index})
      : super(key: key);

  @override
  State<FavIcons> createState() => _FavIconsState();
}


class _FavIconsState extends State<FavIcons> {
  bool favorited = false;
  List<FavSongs> fav = [];
  final box = SongBox.getInstance();
 late  List<Songs> dbSongs;
  @override
  void initState() {
     dbSongs = box.values.toList();
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    fav = favdbsongs.values.toList();
    return
        Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
            padding: const EdgeInsets.only(right: 10, bottom: 20),
            child:
                fav.where((element) =>
                              element.songname == dbSongs[widget.index].songname)
                          .isEmpty
                      ?
                IconButton(
                    onPressed: () {
                      
                        favdbsongs.add(FavSongs(
                            artist: dbSongs[widget.index].artist,
                            duration: dbSongs[widget.index].duration,
                            songname: dbSongs[widget.index].songname,
                            songurl: dbSongs[widget.index].songurl,
                            id: dbSongs[widget.index].id,
                            // index: widget.index,
                            ));
                      
                      setState(() {});
                      
                      print(dbSongs[widget.index].songname);
                      print(favdbsongs.values.toList());

                    },
                    icon: Icon(
                      Icons.favorite_outline_rounded,
                      color: whiteClr,
                    ),splashRadius: 15,)
            :IconButton(
              onPressed: () async{
                            
                    //  if(favdbsongs.length < 1){
                    //   favdbsongs.clear();
                    //   setState(() {
                        
                    //   });
                    //  }else{
                    int currentIndex = fav.indexWhere(
                    (element) => element.songname == dbSongs[widget.index].songname);

                    await favdbsongs.deleteAt(currentIndex);
                    print(currentIndex);
                    setState(() {

                    });
                    //  }
                

                print(widget.index);

              },
              icon:  Icon(Icons.favorite_rounded,color: selectedItemColor,),
              splashRadius: 15,
            )
            ),
        Padding(
          padding: const EdgeInsets.only( bottom: 20),
          child: HomePlaylistButton(
            songindex: widget.index,
          ),
        )
      ],
    );
  }
}