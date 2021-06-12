import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/bloc/provider.dart';
import 'package:flutter_application_1/src/models/auth_model.dart';
import 'package:flutter_application_1/src/providers/auth_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

final authProvider = AuthProvider();

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: _cargarUser(context, bloc.username),
      ),
    );
  }
}

Widget _cargarUser(BuildContext context, username) {
  return FutureBuilder(
    future: authProvider.me(username),
    builder: (BuildContext context, AsyncSnapshot<List<AuthModel>> snapshot) {
      if (snapshot.hasData) {
        return CustomScrollView(slivers: <Widget>[
          SliverAppBar(
              brightness: Brightness.light,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.grey,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              backgroundColor: Colors.white,
              expandedHeight: 200,
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
                              NetworkImage(snapshot.data[0].avatarUrl),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        snapshot.data[0].login,
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ),
              ))
        ]);
      } else {
        return Center(child: CircularProgressIndicator());
      }
    },
  );
}
