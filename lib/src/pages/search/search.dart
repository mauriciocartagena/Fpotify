import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/models/search_model.dart';
import 'package:flutter_application_1/src/pages/search/find.dart';
import 'package:flutter_application_1/src/preferences_user/preferences_user.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Item selectSearch;

  List<Item> historial = [];

  static final String routeName = 'search';

  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    prefs.ultimaPagina = _SearchPageState.routeName;
    return Scaffold(
        backgroundColor: Color.fromRGBO(11, 14, 17, 1.0),
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                final finalResult = await showSearch(
                  context: context,
                  delegate: Find('Buscar...', historial),
                );
                setState(() {
                  this.selectSearch = finalResult;

                  if (finalResult != null) {
                    this.historial.insert(0, finalResult);
                  }
                });
              },
            )
          ],
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromRGBO(11, 14, 17, 1.0),
          brightness: Brightness.dark,
          centerTitle: false,
          title: Text(
            'Search',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Recientes busquedas',
                      style: TextStyle(
                        fontSize: 19.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.delete_outlined,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              if (selectSearch != null)
                Expanded(
                  child: _recentSearches(),
                )
            ],
          ),
        ));
  }

  _recentSearches() {
    return ListView.builder(
      itemCount: historial.length,
      itemBuilder: (context, index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CircleAvatar(
              maxRadius: 37.0,
              backgroundImage:
                  NetworkImage(historial[index].album.images[2].url),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Row(
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        Text(
                          historial[index].name,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          historial[index].artists[0].name,
                          style: TextStyle(
                            color: Colors.white60,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.close,
              color: Colors.white,
            )
          ],
        );
      },
    );
  }
}
