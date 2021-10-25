import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/bloc/login_bloc.dart';

import 'package:flutter_application_1/src/bloc/provider.dart';

import 'package:flutter_application_1/src/preferences_user/preferences_user.dart';
import 'package:flutter_application_1/src/providers/play_list_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollController = new ScrollController();
  final prefs = new PreferenciasUsuario();

  static final String routeName = 'home';
  dynamic _dataMusic;
  int _limit = 5;
  int _offset = 0;

  List<int> _listaNumeros = [];
  int _ultimoItem = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _cargar5();

    // dynamic dataMusic =

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _cargarPlayListMusic();
        // _cargar5();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    prefs.ultimaPagina = _HomePageState.routeName;

    final bloc = Provider.of(context);

    _viewProvider(bloc);

    return Scaffold(
        backgroundColor: Color.fromRGBO(11, 14, 17, 1.0),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromRGBO(11, 14, 17, 0.0),
          brightness: Brightness.dark,
          title: Text(
            'Your Music',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Stack(
          children: <Widget>[_crearList(), _crearLoading()],
        ));
  }

  Future _cargarPlayListMusic() async {
    _isLoading = true;

    final duration = new Duration(seconds: 2);

    setState(() {});

    return new Timer(duration, response);
  }

  void response() {
    _isLoading = false;

    _scrollController.animateTo(
      _scrollController.position.pixels + 100,
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: 250),
    );

    _cargar5();
  }

  _viewProvider(LoginBloc bloc) {
    // if (bloc.username[0].isEmpty) {}
    // print(bloc.idPlayList);
  }
  Widget _crearLoading() {
    if (_isLoading) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
            ],
          ),
          SizedBox(height: 15.0)
        ],
      );
    } else {
      return Container();
    }
  }

  Widget _crearList() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _listaNumeros.length,
      itemBuilder: (BuildContext context, int index) {
        if (_dataMusic == null) {
          return Container();
        } else {
          final imagen = _dataMusic[0].items[index].track.album.images[1].url;

          return FadeInImage(
            placeholder: AssetImage('assets/loading.gif'),
            image: NetworkImage(
              imagen,
            ),
          );
        }
      },
    );
  }

  void _cargar5() async {
    for (var i = 0; i < 5; i++) {
      _ultimoItem++;

      _listaNumeros.add(_ultimoItem);
      _limit = _ultimoItem;
    }
    _dataMusic = await listPlayList(prefs.idPlayList, _limit, _offset);

    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}
