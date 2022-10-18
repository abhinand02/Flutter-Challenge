import 'package:hive_flutter/adapters.dart';

part 'mostplayed_model.g.dart';

@HiveType(typeId: 2)
class MostPlayed {
  @HiveField(0)
  String songname;

  @HiveField(1)
  String artist;

  @HiveField(2)
  int duration;

  @HiveField(3)
  String songurl;

  @HiveField(4)
  int count;

  @HiveField(5)
  int id;

  MostPlayed(
      {required this.songname,
      required this.songurl,
      required this.duration,
      required this.artist,
      required this.count,
      required this.id});
}
