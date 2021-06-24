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
      backgroundColor: Color.fromRGBO(11, 14, 17, 1.0),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(11, 14, 17, 0.0),
        brightness: Brightness.dark,
        title: Text(
          'Cuenta',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        child: _cargarUser(context),
      ),
    );
  }
}

Widget _cargarUser(BuildContext context) {
  return FutureBuilder(
    future: me(),
    builder: (BuildContext context, AsyncSnapshot<List<AuthModelMe>> snapshot) {
      if (snapshot.hasData) {
        return CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              brightness: Brightness.light,
              backgroundColor: Colors.transparent,
              expandedHeight: 300,
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
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, 'login'),
                        child: Text(
                          'Logout',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 45,
                      ),
                      Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Text(
                                  'PLAYLISTS',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Text(
                                  'FOLLOWERS',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Text(
                                  'FOLLOWING',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      } else {
        return Center(child: CircularProgressIndicator());
      }
    },
  );
}
