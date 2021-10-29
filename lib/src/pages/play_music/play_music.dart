import 'dart:ui';

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
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    final _maxWidth = queryData.size.width;
    final _maxHeight = queryData.size.height;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                child: ClipRRect(
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Image.network(
                      'https://cdns-images.dzcdn.net/images/cover/e24ae59ad933185bd6689d388eb0f256/350x350.jpg',
                      fit: BoxFit.cover,
                      height: _maxHeight,
                      width: _maxWidth,
                    ),
                  ),
                ),
              ),

              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    _titulos(),
                    SafeArea(
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                        child: Image.network(
                          'https://cdns-images.dzcdn.net/images/cover/e24ae59ad933185bd6689d388eb0f256/350x350.jpg',
                          width: 350,
                          height: 350,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    _player()
                  ],
                ),
              ),
              // _fondoApp(),
            ],
          ),
        ],
      ),
      backgroundColor: Color.fromRGBO(11, 14, 17, 1.0),
    );
  }

  Widget _titulos() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Play Music',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
            ),
          ],
        ),
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
              return _tab(
                [
                  Text(
                    snapshot.data.musicaActual,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  _slider(snapshot.data),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '00' + ":" + "00",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        snapshot.data.duration.inMinutes.toString() +
                            ':' +
                            (snapshot.data.duration.inSeconds -
                                    (snapshot.data.duration.inMinutes * 60))
                                .toString(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  _acoes(snapshot.data),
                ],
              );
            },
          ),
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
          color: Colors.white,
          iconSize: 50,
        ),
        IconButton(
          onPressed: () {
            audioC.buttonPlayPause();
          },
          color: Colors.white,
          iconSize: 50,
          icon: Icon(objeto.play == true
              ? Icons.pause_circle_filled
              : Icons.play_circle_filled),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.skip_next),
          color: Colors.white,
          iconSize: 50,
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
      activeColor: Colors.white,
      inactiveColor: Colors.grey,
      min: 0.0,
      onChanged: (value) {
        setState(() {
          audioC.timeMusic(value);
        });
      },
    );
  }
}
