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
        body: ListView.builder(
          itemCount: widget.list.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                widget.list[index],
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  backgroundColor: Color.fromRGBO(11, 14, 17, 1.0),
                ),
              ),
            );
          },
        ));
  }
}
