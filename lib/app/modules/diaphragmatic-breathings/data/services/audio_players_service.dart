import 'package:audioplayers/audioplayers.dart';

abstract interface class IAudioPlayerService {
  Future playAudio(String url);
  Future stopAudio();
}

class AudioPlayerService implements IAudioPlayerService {
  final AudioPlayer player;

  AudioPlayerService({required this.player});

  @override
  Future playAudio(String url) async {
    try {
      await player.play(UrlSource(url));
    } catch (e) {
      print("error: $e");
    }
  }

  @override
  Future<void> stopAudio() async {
    await player.stop();
  }
}
