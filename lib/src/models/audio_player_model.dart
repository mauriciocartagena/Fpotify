import 'package:audioplayers/audioplayers.dart';

class AudioPlayerModel {
  AudioPlayer _advancedPlayer;
  AudioCache _audioCache;
  String _localFielPath;
  double _sliderVal;
  Duration _duration;
  Duration _position;
  String _timeSong = '';
  bool _play = false;
  String _musicaActual = '';

  AudioPlayerModel(
    this._advancedPlayer,
    this._audioCache,
    this._localFielPath,
    this._sliderVal,
    this._duration,
    this._position,
    this._timeSong,
    this._play,
    this._musicaActual,
  );

  AudioPlayer get advancedPlayer => _advancedPlayer;

  set advancedPlayer(AudioPlayer advancedPlayer) {
    _advancedPlayer = advancedPlayer;
  }

  AudioCache get audioCache => _audioCache;

  set audioCache(AudioCache audioCache) {
    _audioCache = audioCache;
  }

  String get localFielPath => _localFielPath;

  set localFielPath(String localFielPath) {
    _localFielPath = localFielPath;
  }

  double get sliderVal => _sliderVal;

  set sliderVal(double sliderVal) {
    _sliderVal = sliderVal;
  }

  Duration get duration => _duration;

  set duration(Duration duration) {
    _duration = duration;
  }

  Duration get position => _position;

  set position(Duration position) {
    _position = position;
  }

  String get timeSong => _timeSong;

  set timeSong(String timeSong) {
    _timeSong = timeSong;
  }

  bool get play => _play;

  set play(bool play) {
    _play = play;
  }

  String get musicaActual => _musicaActual;

  set musicaActual(String musicaActual) {
    _musicaActual = musicaActual;
  }
}
