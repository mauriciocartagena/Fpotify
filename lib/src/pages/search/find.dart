import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/src/models/search_model.dart';
import 'package:flutter_application_1/src/providers/search_provider.dart';

class Find extends SearchDelegate<Item> {
  @override
  final String searchFieldLabel;
  final List<Item> historial;

  Find(this.searchFieldLabel, this.historial);

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: AppBarTheme(
        backwardsCompatibility: false, // 1
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Color.fromRGBO(11, 14, 17, 1.0),
      ),
      scaffoldBackgroundColor: Color.fromRGBO(11, 14, 17, 1.0),
      hintColor: Colors.white,
      textTheme: TextTheme(
        subtitle1: TextStyle(
          color: Colors.white,
        ),
        headline6: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
      ),
    );
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () => this.close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.trim().length == 0) {
      return Text('No hay valor en el query');
    }

    return FutureBuilder(
      future: search('track', query, 5),
      builder: (_, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return ListTile(title: Text('No hay nada con ese término'));
        }
        if (snapshot.hasData) {
          return _showMusic(snapshot.data);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (historial == null) {
      return Container();
    } else {
      return _showMusic(this.historial);
    }
  }

  Widget _showMusic(List<Item> music) {
    return ListView.builder(
      itemCount: music.length,
      itemBuilder: (context, i) {
        final result = music[i];

        return ListTile(
          leading: FadeInImage.assetNetwork(
            placeholder: 'assets/loading.gif',
            image: result.album.images[1].url,
          ),
          title: Text(
            result.name,
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            result.artists[0].name,
            style: TextStyle(color: Colors.white),
          ),
          trailing: Text(
            '${result.popularity}',
            style: TextStyle(color: Colors.white),
          ),
          onTap: () {
            this.close(context, result);
          },
        );
      },
    );
  }
}
