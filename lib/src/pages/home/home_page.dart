import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/preferences_user/preferences_user.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final String routeName = 'home';

  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    prefs.ultimaPagina = _HomePageState.routeName;

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Text('Home Page')
          ],
        ),
      ),
    );
  }
}
