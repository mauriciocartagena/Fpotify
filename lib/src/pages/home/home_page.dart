import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/preferences_user/preferences_user.dart';
import 'package:flutter_application_1/src/providers/play_list_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final String routeName = 'home';

  final prefs = new PreferenciasUsuario();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listPlayList('5tyneaeBQREnBe06qagqwO', 5, 0);
  }

  @override
  Widget build(BuildContext context) {
    prefs.ultimaPagina = _HomePageState.routeName;
    return Scaffold(
      backgroundColor: Color.fromRGBO(11, 14, 17, 1.0),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(11, 14, 17, 0.0),
        brightness: Brightness.dark,
        title: Text(
          'Home',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
          child: Text(
        'Home Page',
        style: TextStyle(color: Colors.white),
      )),
    );
  }
}
