import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/models/auth_model_me.dart';
import 'package:flutter_application_1/src/models/follower_model.dart';
import 'package:flutter_application_1/src/models/play_list_model.dart';
import 'package:flutter_application_1/src/preferences_user/preferences_user.dart';
import 'package:flutter_application_1/src/providers/auth_provider.dart';
import 'package:flutter_application_1/src/providers/play_list_provider.dart';
import 'package:flutter_application_1/src/providers/user_followers.dart';

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
      backgroundColor: Color.fromRGBO(25, 20, 20, 1.0),
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
              expandedHeight: 345,
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
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/loading.gif',
                            image: (snapshot.data[0].images.isNotEmpty)
                                ? snapshot.data[0].images[0].url
                                : 'https://www.csudh.edu/Assets/global/images/avatars/avatar-cccccc-600x600.png',
                          ),
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
                        onPressed: () => _logout(context),
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
                                  child: _playList(context)),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: _followers(context)),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: _following(context)),
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
        return Center(
            child: CircularProgressIndicator(
          color: Color.fromRGBO(30, 215, 96, 1),
        ));
      }
    },
  );
}

_logout(BuildContext context) {
  final prefs = new PreferenciasUsuario();

  prefs.tokenUser = '';
  prefs.tokenRefresh = '';
  return Navigator.pushNamed(context, 'login');
}

Widget _playList(BuildContext context) {
  return FutureBuilder(
    future: playList(),
    builder: (BuildContext context,
        AsyncSnapshot<List<AuthModelPLayList>> snapshot) {
      if (snapshot.hasData) {
        return Column(
          children: <Widget>[
            Text(
              'PLAYLIST',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              snapshot.data[0].total.toString(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );
      } else {
        return Column(
          children: <Widget>[
            Text(
              'PLAYLIST',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '0',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );
      }
    },
  );
}

Widget _followers(BuildContext context) {
  return FutureBuilder(
    future: me(),
    builder: (BuildContext context, AsyncSnapshot<List<AuthModelMe>> snapshot) {
      if (snapshot.hasData) {
        return Column(
          children: <Widget>[
            Text(
              'FOLLOWERS',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              snapshot.data[0].followers.total.toString(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );
      } else {
        return Column(
          children: <Widget>[
            Text(
              'FOLLOWERS',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '0',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );
      }
    },
  );
}

Widget _following(BuildContext context) {
  return FutureBuilder(
    future: getFollowers(),
    builder:
        (BuildContext context, AsyncSnapshot<List<FollowerModel>> snapshot) {
      if (snapshot.hasData) {
        return Column(
          children: <Widget>[
            Text(
              'FOLLOWING',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              snapshot.data[0].artists.total.toString(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );
      } else {
        return Column(
          children: <Widget>[
            Text(
              'FOLLOWING',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '0',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );
      }
    },
  );
}
