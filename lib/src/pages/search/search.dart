import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/pages/search/find.dart';
import 'package:flutter_application_1/src/preferences_user/preferences_user.dart';

class SearchPage extends StatefulWidget {
  final List<String> list = List.generate(10, (index) => "text $index");

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
              onPressed: () {
                showSearch(context: context, delegate: Find(widget.list));
              },
            ),
          ],
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromRGBO(11, 14, 17, 1.0),
          brightness: Brightness.dark,
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
              Expanded(
                child: _recentSearches(),
              )
            ],
          ),
        ));
  }

  _recentSearches() {
    return ListView.builder(
      itemCount: widget.list.length,
      itemBuilder: (context, index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CircleAvatar(
              maxRadius: 37.0,
              backgroundImage: NetworkImage(
                'https://as.com/diarioas/imagenes/2021/05/19/actualidad/1621414987_960174_1621415108_noticia_normal_recorte1.jpg',
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 160, 0),
              child: Row(
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Rammstein',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'By Hello',
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
        // ListTile(
        //   title: Text(
        //     'Number ${index}',
        //     style: TextStyle(color: Colors.blue),
        //   ),
        // );
      },
    );
  }
}
