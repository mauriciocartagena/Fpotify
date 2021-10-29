import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_application_1/src/models/audio_player_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class AudioPlayerController extends BlocBase {
  BehaviorSubject<AudioPlayerModel> durB =
      new BehaviorSubject<AudioPlayerModel>();

  Stream<AudioPlayerModel> get outPlayer => durB.stream;
  Sink<AudioPlayerModel> get inPlayer => durB.sink;

  AudioPlayer advancedPlayer = new AudioPlayer();

  AudioPlayerModel audioModel;

  AudioPlayerController() : super(null) {
    audioModel = new AudioPlayerModel(
      advancedPlayer,
      new AudioCache(fixedPlayer: advancedPlayer),
      "",
      0,
      new Duration(),
      new Duration(),
      "",
      false,
      "",
    );

    audioModel.advancedPlayer.onDurationChanged.listen((Duration d) {
      audioModel.duration = d;
      inPlayer.add(audioModel);
    });
    audioModel.advancedPlayer.onAudioPositionChanged.listen((Duration p) {
      audioModel.position = p;
      inPlayer.add(audioModel);
    });

    audioModel.musicaActual = "Rammstein.mp3";
    inPlayer.add(audioModel);
  }
  timeMusic(double value) {
    Duration newDuration = Duration(seconds: value.toInt());

    audioModel.advancedPlayer.seek(newDuration);

    audioModel.timeSong = value.toStringAsFixed(0);

    audioModel.advancedPlayer.resume();

    audioModel.play = true;

    inPlayer.add(audioModel);

    print(value.toInt());
  }

  buttonPlayPause() {
    if (audioModel.play) {
      audioModel.play = false;
      audioModel.advancedPlayer.pause();
    } else {
      audioModel.play = true;
      audioModel.audioCache.play(audioModel.musicaActual);
    }
    inPlayer.add(audioModel);
  }

  selectMusic(String musica) {
    audioModel.musicaActual = musica;

    audioModel.audioCache.play(audioModel.musicaActual);
    audioModel.play = true;
    inPlayer.add(audioModel);
  }

  @override
  void dispose() {}
}

AudioPlayerController audioC = new AudioPlayerController();
