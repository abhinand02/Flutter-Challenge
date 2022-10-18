import 'package:hive_flutter/adapters.dart';
import 'model.dart';

part 'playlistmodel.g.dart';

@HiveType(typeId: 3)
class PlaylistSongs{

  @HiveField(0)
  String playlistname;

  @HiveField(1)
  List<Songs>? playlistsongs;

  PlaylistSongs({required this.playlistname, required this.playlistsongs});
}