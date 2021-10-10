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
  static final String routeName = 'home';

  final prefs = new PreferenciasUsuario();

  List<int> _listaNumeros = [1, 2, 3, 4, 5];

  @override
  void initState() {
    super.initState();
    _cargarPlayListMusic('5tyneaeBQREnBe06qagqwO', 5, 0);
  }

  @override
  Widget build(BuildContext context) {
    prefs.ultimaPagina = _HomePageState.routeName;

    final bloc = Provider.of(context);

    print(bloc);
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
      body: _crearList(),
    );
  }

  _cargarPlayListMusic(id, limit, offset) async {
    final data = await listPlayList(id, limit, offset);

    // return
    // print(data[0].items[1].track.album.images[1].url);
    return {limit, data[0]};
  }

  _viewProvider(LoginBloc bloc) {
    // if (bloc.username[0].isEmpty) {}
    // print(bloc.idPlayList);
  }

  Widget _crearList() {
    return ListView.builder(
      itemCount: _listaNumeros.length,
      itemBuilder: (BuildContext context, int index) {
        final imagen = _listaNumeros[index];
        return FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(
            'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcQU2JRbbl3LBOm_an3eI5iplFhOoLESyBwUfmWDO49BS1EYuGUE',
          ),
        );
      },
    );
  }

  _cargar5(id) {}
}
