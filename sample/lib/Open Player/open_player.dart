import 'package:assets_audio_player/assets_audio_player.dart';

class OpenPlayer {
  List<Audio> allsongs;
  int index;

  OpenPlayer(
      { required this.allsongs, required this.index});

  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();

  openAssetPlayer({List<Audio>? songs, required int index}) async {
    audioPlayer.open(Playlist(audios: songs, startIndex: index),
        notificationSettings: const NotificationSettings(
          stopEnabled: false,
        ),
        autoStart: true,
        loopMode: LoopMode.playlist,
        headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
        playInBackground: PlayInBackground.enabled);
  }
}
