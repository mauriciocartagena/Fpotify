import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/models/play_list_model.dart';
import 'package:flutter_application_1/src/providers/play_list_provider.dart';

class ListaPage extends StatefulWidget {
  @override
  _ListaPageState createState() => _ListaPageState();
}

class _ListaPageState extends State<ListaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List'),
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
                    child: FadeInImage(
                      image: NetworkImage(
                        snapshot.data[0].items[index].images[0].url,
                      ),
                      placeholder: AssetImage('assets/loading.gif'),
                    ),
                  ),
                  Text(snapshot.data[0].items[index].name),
                ],
              );
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
