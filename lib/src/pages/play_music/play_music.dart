import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/bloc/AudioPlayerController.dart';
import 'package:flutter_application_1/src/models/audio_player_model.dart';

class PlayMusic extends StatefulWidget {
  @override
  _PlayMusicState createState() => _PlayMusicState();
}

class _PlayMusicState extends State<PlayMusic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Play'),
      ),
      body: Container(
        child: _player(),
      ),
    );
  }

  Widget _player() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          StreamBuilder(
              stream: audioC.outPlayer,
              builder: (context, AsyncSnapshot<AudioPlayerModel> snapshot) {
                print(snapshot.data.duration);
                return _tab(
                  [
                    Text(snapshot.data.musicaActual),
                    _slider(snapshot.data),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('00' + ":" + "00"),
                        Text(
                          snapshot.data.duration.inMinutes.toString() +
                              ':' +
                              (snapshot.data.duration.inSeconds -
                                      (snapshot.data.duration.inMinutes * 60))
                                  .toString(),
                        ),
                      ],
                    ),
                    _acoes(snapshot.data),
                  ],
                );
              })
        ],
      ),
    );
  }

  Widget _acoes(AudioPlayerModel objeto) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.skip_previous),
        ),
        IconButton(
          onPressed: () {
            audioC.buttonPlayPause();
          },
          icon: Icon(objeto.play == true
              ? Icons.pause_circle_filled
              : Icons.play_circle_filled),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.skip_next),
        )
      ],
    );
  }

  Widget _tab(List<Widget> children) {
    return Container(
      child: Column(
        children: children
            .map(
              (e) => Container(
                child: e,
                padding: EdgeInsets.all(6),
              ),
            )
            .toList(),
      ),
    );
  }

  double temp = 0;

  Widget _slider(AudioPlayerModel objeto) {
    return Slider(
      value: objeto.position.inSeconds.toDouble(),
      max: objeto.duration.inSeconds.toDouble(),
      min: 0.0,
      onChanged: (value) {
        setState(() {
          audioC.timeMusic(value);
        });
      },
    );
  }
}
