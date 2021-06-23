import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/preferences_user/preferences_user.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  static final String routeName = 'search';

  final prefs = new PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    prefs.ultimaPagina = _SearchPageState.routeName;
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 100,
          ),
          Text('Search')
        ],
      ),
    );
  }
}
