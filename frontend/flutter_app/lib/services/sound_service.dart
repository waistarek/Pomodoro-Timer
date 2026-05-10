import 'package:audioplayers/audioplayers.dart';

class SoundService {
  final AudioPlayer _player = AudioPlayer();

  Future<void> playPhaseFinishedSound() async {
    await _player.play(AssetSource('audios/bells.mp3'));
  }
}
