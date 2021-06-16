import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/providers/auth_provider.dart';
import 'package:flutter_application_1/src/utills/utils.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:translator/translator.dart';
import 'package:transparent_image/transparent_image.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[_crearFondo(context), _loginForm(context)],
      ),
    );
  }
}

Widget _loginForm(BuildContext context) {
  final size = MediaQuery.of(context).size;

  return SimpleDialogOption(
      child: Expanded(
    child: Column(
      children: <Widget>[
        SafeArea(
            child: Container(
          height: 180.0,
        )),
        Container(
          margin: EdgeInsets.symmetric(vertical: 50.0),
          width: size.width * 0.85,
          padding: EdgeInsets.symmetric(vertical: 50.0),
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
              ]),
          child: Column(
            children: <Widget>[
              _mensaje('Welcome'),
              SizedBox(
                height: 60.0,
              ),
              _crearButton(
                Buttons.GitHub,
                'Log in with GitHub',
                () => {_login(context)},
              ),
              SizedBox(
                height: 40.0,
              ),
              _crearButton(
                Buttons.Twitter,
                'Log in with Twitter',
                () => {},
              ),
            ],
          ),
        ),
        Expanded(
          child: Text('¿Olvido su contrasena?'),
        ),
      ],
    ),
  ));
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
              width: double.infinity,
              child: Text(
                snapshot.data,
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 25.0,
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

Widget _crearButton(type, name, event) {
  final title = name == null ? 'No have title' : name;

  return FutureBuilder(
      future: _tranlator(title),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Container(
            child: SignInButton(
              type,
              text: snapshot.data,
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
          Color.fromRGBO(07, 43, 54, 1.0),
          Color.fromRGBO(07, 43, 54, 1.0),
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
                  padding: EdgeInsets.only(top: 205.0),
                  child: Positioned(
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
                )
              ],
            ),
          ],
        ),
      )
    ],
  );
}

_login(bloc) async {
  final userProvider = new AuthProvider();
  final info = await userProvider.authGitHub();
  if (info['ok']) {
    Navigator.pushReplacementNamed(bloc, 'home');
  } else {
    mostrarAlerta(bloc, info['mensaje']);
  }
}
