import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/preferences_user/preferences_user.dart';
import 'package:flutter_application_1/src/providers/auth_provider.dart';
import 'package:flutter_application_1/src/utills/utils.dart';
import 'package:translator/translator.dart';
import 'package:transparent_image/transparent_image.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _loginForm(context),
        ],
      ),
    );
  }
}

Widget _loginForm(BuildContext context) {
  final size = MediaQuery.of(context).size;

  return SimpleDialogOption(
    child: Column(
      children: <Widget>[
        SafeArea(
          child: Container(
            height: 180.0,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 50.0),
          width: size.width * 0.85,
          padding: EdgeInsets.symmetric(vertical: 40.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black26,
                blurRadius: 3.0,
                offset: Offset(0.0, 5.0),
                spreadRadius: 3.0,
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              _mensaje('To continue, log into.'),
              SizedBox(
                height: 35.0,
              ),
              _crearButton(
                'Log in',
                Icons.login,
                () => _authenticateSpotify(context),
              ),
              SizedBox(
                height: 17.0,
              ),
            ],
          ),
        ),
        Expanded(
          child: Text('¿Olvitaste tu contraseña?'),
        ),
      ],
    ),
  );
}

Future<String> _tranlator(data) async {
  final translator = GoogleTranslator();
  final input = data;

  final inputTranslator =
      await translator.translate(input, from: 'en', to: 'es');
  return '$inputTranslator';
}

Widget _mensaje(title) {
  return FutureBuilder(
    future: _tranlator(title),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.hasData) {
        return Container(
          child: Container(
            child: SizedBox(
              // width: double.infinity,
              child: Text(
                snapshot.data,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.5,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 25),
        );
      } else {
        return CircularProgressIndicator();
      }
    },
  );
}

Widget _crearEmail() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20.0),
    child: TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          icon: Icon(Icons.alternate_email, color: Colors.deepPurple),
          hintText: 'example@gmail.com',
          labelText: 'Correo Electronico'),
    ),
  );
}

Widget _crearPassword() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20.0),
    child: TextField(
      obscureText: true,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          icon: Icon(Icons.lock_outline, color: Colors.deepPurple),
          labelText: 'Contrasena'),
    ),
  );
}

Widget _crearButton(name, icon, event) {
  final title = name == null ? 'No have title' : name;

  return FutureBuilder(
      future: _tranlator(title),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Container(
            child: ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(30, 120, 47, 1)),
                overlayColor: MaterialStateProperty.resolveWith(
                  (states) {
                    return states.contains(MaterialState.pressed)
                        ? Color.fromRGBO(36, 145, 55, 1)
                        : null;
                  },
                ),
              ),
              label: Text(snapshot.data),
              icon: Icon(icon),
              onPressed: event,
            ),
            width: 460,
            height: 50.0,
            padding: EdgeInsets.symmetric(horizontal: 25.0),
          );
        } else {
          return CircularProgressIndicator();
        }
      });
}

Widget _crearFondo(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final fondoMorado = Container(
    height: size.height * 0.4,
    width: double.infinity,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Color.fromRGBO(10, 32, 41, 1.0),
          Color.fromRGBO(10, 32, 41, 1.0),
        ],
      ),
    ),
  );

  final circulo = Container(
    width: 100.0,
    height: 100.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100.0),
      color: Color.fromRGBO(255, 255, 255, 0.05),
    ),
  );

  return Stack(
    // EdgeInsets.only(top: 205.0)
    children: <Widget>[
      fondoMorado,
      Positioned(top: 90.0, left: 30.0, child: circulo),
      Positioned(top: -40.0, right: -30.0, child: circulo),
      Positioned(bottom: -50.0, right: -10.0, child: circulo),
      Positioned(bottom: 120.0, right: 20.0, child: circulo),
      Positioned(bottom: -50.0, left: -20.0, child: circulo),
      Container(
        padding: EdgeInsets.only(top: 23.0),
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                FadeInImage(
                  width: double.infinity,
                  height: 120,
                  placeholder: MemoryImage(kTransparentImage),
                  image: AssetImage('assets/adaptive-icon.png'),
                ),
                Container(
                  padding: EdgeInsets.only(top: 155.0),
                  child: Text(
                    'Fpotify',
                    style: TextStyle(
                      color: Colors.white,
                      // fontFamily: 'GothamMediumItalic',
                      fontSize: 30,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    ],
  );
}

_authenticateSpotify(bloc) async {
  final resp = await authenticate();

  if (resp['ok']) {
    Navigator.pushReplacementNamed(bloc, 'index');
  } else {
    mostrarAlerta(bloc, resp['error']);
  }
}
