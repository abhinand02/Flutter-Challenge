import 'package:flutter/material.dart';
import '../Model/db_functions.dart';
import '../Model/favmodel.dart';
import '../Model/model.dart';
import '../Playlist/homeplaylistbutton.dart';
import '../constants/style.dart';

class FavIcons extends StatefulWidget {
  int index;

  FavIcons({Key? key, required this.index}) : super(key: key);

  @override
  State<FavIcons> createState() => _FavIconsState();
}

class _FavIconsState extends State<FavIcons> {
  bool favorited = false;
  List<FavSongs> fav = [];
  final box = SongBox.getInstance();
  late List<Songs> dbSongs;
  @override
  void initState() {
    dbSongs = box.values.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fav = favdbsongs.values.toList();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10, bottom: 20),
          child: fav
                  .where((element) =>
                      element.songname == dbSongs[widget.index].songname)
                  .isEmpty
              ? IconButton(
                  onPressed: () {
                    favdbsongs.add(
                      FavSongs(
                        artist: dbSongs[widget.index].artist,
                        duration: dbSongs[widget.index].duration,
                        songname: dbSongs[widget.index].songname,
                        songurl: dbSongs[widget.index].songurl,
                        id: dbSongs[widget.index].id,
                        // index: widget.index,
                      ),
                    );

                    setState(() {});
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: selectedItemColor,
                        duration: const Duration(seconds: 1),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        content: Text(
                          '${dbSongs[widget.index].songname}Added to favourites',
                        ),
                      ),
                    );
                    // print(dbSongs[widget.index].songname);
                    // print(favdbsongs.values.toList());
                  },
                  icon: const Icon(
                    Icons.favorite_outline_rounded,
                  ),
                  splashRadius: 15,
                )
              : IconButton(
                  onPressed: () async {
                    int currentIndex = fav.indexWhere((element) =>
                        element.songname == dbSongs[widget.index].songname);
                    await favdbsongs.deleteAt(currentIndex);
                    // print(currentIndex);
                    setState(() {});

                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: selectedItemColor,
                        duration: const Duration(seconds: 1),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        content: Text(
                            '${dbSongs[widget.index].songname} Removed from favourites'),
                      ),
                    );

                    // print(widget.index);
                  },
                  icon: Icon(
                    Icons.favorite_rounded,
                    color: selectedItemColor,
                  ),
                  splashRadius: 15,
                ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: HomePlaylistButton(
            songindex: widget.index,
          ),
        )
      ],
    );
  }
}
