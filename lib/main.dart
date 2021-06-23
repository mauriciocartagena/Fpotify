import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/pages/account/account.dart';
import 'package:flutter_application_1/src/pages/home/home_page.dart';
import 'package:flutter_application_1/src/pages/index.dart';
import 'package:flutter_application_1/src/pages/login_page.dart';
import 'package:flutter_application_1/src/bloc/provider.dart';
import 'package:flutter_application_1/src/pages/play_list/listview_page.dart';
import 'package:flutter_application_1/src/pages/search/search.dart';
import 'package:flutter_application_1/src/preferences_user/preferences_user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await dotenv.load(fileName: ".env");
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prefs = new PreferenciasUsuario();

    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fpotify',
        initialRoute: prefs.tokenUser != null ? 'index' : 'login',
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'index': (BuildContext context) => Index(),
          'account': (BuildContext context) => AccountPage(),
          'play_list': (BuildContext context) => ListaPage(),
          'search': (BuildContext context) => SearchPage(),
          'home': (BuildContext context) => HomePage(),
        },
      ),
    );
  }
}
