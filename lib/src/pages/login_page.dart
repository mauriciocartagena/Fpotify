import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Stack(children: <Widget>[_crearFondo(context), _loginForm(context)]),
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
                  'https://midu.dev/images/tags/github.png',
                  'Log in with GitHub',
                ),
                SizedBox(
                  height: 40.0,
                ),
                _crearButton(
                  'https://freepikpsd.com/media/2019/10/twitter-logo-white-png-4-Transparent-Images-Free.png',
                  'Log in with Twitter',
                )
              ],
            )),
        Text('¿Olvido su contrasena?'),
        SizedBox(
          height: 30.0,
        )
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
      });
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

Widget _crearButton(url, name) {
  final urlImage =
      url == null ? 'https://midu.dev/images/tags/github.png' : url;
  final title = name == null ? 'No have title' : name;

  return FutureBuilder(
      future: _tranlator(title),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Container(
            child: TextButton.icon(
              onPressed: () => Navigator.pushNamed(context, 'home'),
              icon: Image.network(
                urlImage,
                height: 40.0,
                width: 40.0,
                color: Colors.white,
              ),
              label: Expanded(
                  child: Text(
                snapshot.data,
                style: TextStyle(
                  color: Colors.white,
                ),
              )),
              style: TextButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
                elevation: 0.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
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
        gradient: LinearGradient(colors: <Color>[
      Color.fromRGBO(63, 63, 156, 1.0),
      Color.fromRGBO(90, 70, 178, 1.0)
    ])),
  );

  final circulo = Container(
    width: 100.0,
    height: 100.0,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.05)),
  );

  final urlImage = 'https://midu.dev/images/tags/github.png';

  return Stack(
    children: <Widget>[
      fondoMorado,
      Positioned(top: 90.0, left: 30.0, child: circulo),
      Positioned(top: -40.0, right: -30.0, child: circulo),
      Positioned(bottom: -50.0, right: -10.0, child: circulo),
      Positioned(bottom: 120.0, right: 20.0, child: circulo),
      Positioned(bottom: -50.0, left: -20.0, child: circulo),
      Container(
        padding: EdgeInsets.only(top: 80.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child: Image.network(urlImage, width: 140.0, color: Colors.white,
                  loadingBuilder: (context, child, progress) {
                return progress == null
                    ? child
                    : CircularProgressIndicator(
                        strokeWidth: 5,
                      );
              }),
            ),
            Text(
              'Fpotify',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                letterSpacing: 2,
              ),
            ),
            SizedBox(
              height: 10.0,
              width: double.infinity,
            ),
          ],
        ),
      )
    ],
  );
}
