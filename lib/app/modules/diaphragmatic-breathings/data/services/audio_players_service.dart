import 'package:just_audio/just_audio.dart';

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
      await player.setVolume(50);
      await player.setAudioSource(AudioSource.uri(Uri.parse(url)));
      await player.play();
    } catch (e) {
      print("error: $e");
    }
  }

  @override
  Future<void> stopAudio() async {
    await player.stop();
  }
}
