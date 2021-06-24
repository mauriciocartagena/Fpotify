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
      backgroundColor: Color.fromRGBO(11, 14, 17, 1.0),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(11, 14, 17, 0.0),
        brightness: Brightness.dark,
        title: Text(
          'Search',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
          child: Text(
        'Search Page',
        style: TextStyle(color: Colors.white),
      )),
    );
  }
}
