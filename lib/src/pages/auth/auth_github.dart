import 'package:flutter_application_1/src/bloc/login_bloc.dart';
import 'package:flutter_application_1/src/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/providers/auth_provider.dart';
import 'package:flutter_application_1/src/utills/utils.dart';

class AuthGitHub extends StatefulWidget {
  @override
  _AuthGitHubState createState() => _AuthGitHubState();
}

class _AuthGitHubState extends State<AuthGitHub> {
  TextEditingController _controller = TextEditingController();

  final userProvider = new AuthProvider();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.black,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 200,
                ),
                Container(
                  width: 80,
                  height: 80,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(
                        'https://icon-library.net/images/github-icon-png/github-icon-png-29.jpg'),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'GitHub',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                _crearUsername(bloc, context),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  padding: EdgeInsets.all(20),
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Align(
                    child: Text(
                      'Iniciar sessión',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onPressed: () => _login(bloc),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearUsername(LoginBloc bloc, BuildContext context) {
    return StreamBuilder(
      stream: bloc.usernameStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white.withOpacity(.1),
            ),
            child: TextField(
              controller: _controller,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Tu username',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
              onChanged: bloc.changeUsername,
            ),
          ),
        );
      },
    );
  }

  _login(LoginBloc bloc) async {
    final info = await userProvider.cargarInformacion(bloc.username);
    if (info['ok']) {
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      mostrarAlerta(context, info['mensaje']);
    }
  }
}
