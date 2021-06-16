import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/pages/auth/auth_github.dart';
import 'package:flutter_application_1/src/pages/home_page.dart';
import 'package:flutter_application_1/src/pages/login_page.dart';
import 'package:flutter_application_1/src/bloc/provider.dart';
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
    print(prefs.username);

    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fpotify',
        initialRoute: 'login',
        // initialRoute: prefs.ultimaPagina,
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'auth-github': (BuildContext context) => AuthGitHub(),
          'home': (BuildContext context) => HomePage(),
        },
      ),
    );
  }
}
