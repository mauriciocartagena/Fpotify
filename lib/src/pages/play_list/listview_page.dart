import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/models/play_list_model.dart';
import 'package:flutter_application_1/src/preferences_user/preferences_user.dart';
import 'package:flutter_application_1/src/providers/play_list_provider.dart';

class ListaPage extends StatefulWidget {
  @override
  _ListaPageState createState() => _ListaPageState();
}

class _ListaPageState extends State<ListaPage> {
  static final String routeName = 'play_list';

  final prefs = new PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    prefs.ultimaPagina = _ListaPageState.routeName;
    return Scaffold(
      backgroundColor: Color.fromRGBO(11, 14, 17, 1.0),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(11, 14, 17, 0.0),
        brightness: Brightness.dark,
        title: Text(
          'Your Playlists',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          _crearLista(context),
        ],
      ),
    );
  }

  Widget _crearLista(BuildContext context) {
    return FutureBuilder(
      future: playList(),
      builder: (BuildContext context,
          AsyncSnapshot<List<AuthModelPLayList>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data[0].total,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: FadeInImage(
                        fit: BoxFit.cover,
                        placeholder: AssetImage('assets/loading.gif'),
                        image: NetworkImage(
                          snapshot.data[0].items[index].images[0].url,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    snapshot.data[0].items[index].name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Creado por : ${snapshot.data[0].items[index].owner.displayName}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  )
                ],
              );
            },
          );
        } else {
          return Center(
              child: CircularProgressIndicator(
            color: Color.fromRGBO(43, 175, 67, 1),
          ));
        }
      },
    );
  }
}
