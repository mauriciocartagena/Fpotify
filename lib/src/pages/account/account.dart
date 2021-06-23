import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/models/auth_model_me.dart';
import 'package:flutter_application_1/src/preferences_user/preferences_user.dart';
import 'package:flutter_application_1/src/providers/auth_provider.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  static final String routeName = 'account';

  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    prefs.ultimaPagina = _AccountPageState.routeName;

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: _cargarUser(context, prefs.tokenUser),
      ),
    );
  }
}

Widget _cargarUser(BuildContext context, token) {
  return FutureBuilder(
    future: me(token),
    builder: (BuildContext context, AsyncSnapshot<List<AuthModelMe>> snapshot) {
      if (snapshot.hasData) {
        return CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              brightness: Brightness.light,
              backgroundColor: Colors.white,
              expandedHeight: 227,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 100,
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundColor: Colors.transparent,
                          backgroundImage:
                              NetworkImage(snapshot.data[0].images[0].url),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        snapshot.data[0].displayName,
                        style: TextStyle(fontSize: 20),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, 'login'),
                        child: Text('Logout'),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      } else {
        return Center(child: CircularProgressIndicator());
      }
    },
  );
}
