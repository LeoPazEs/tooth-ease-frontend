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
    await player.play(UrlSource(url));
  }

  @override
  Future stopAudio() {
    // TODO: implement stopAudio
    throw UnimplementedError();
  }
}
