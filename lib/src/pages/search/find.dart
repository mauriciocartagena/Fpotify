import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Find extends SearchDelegate {
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
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  String selectedResult;

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      color: Color.fromRGBO(11, 14, 17, 1.0),
      child: Center(
        child: Text(
          selectedResult,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  final List<String> listExample;
  Find(this.listExample);

  List<String> recentList = ['Text 4', 'text 3'];

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];
    query.isEmpty
        ? suggestionList = recentList
        : suggestionList
            .addAll(listExample.where((element) => element.contains(query)));

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            suggestionList[index],
          ),
          leading: FadeInImage.assetNetwork(
            fadeOutCurve: Curves.easeInCubic,
            placeholder: 'assets/loading.gif',
            fit: BoxFit.cover,
            image:
                'https://confilegal.com/wp-content/uploads/2016/01/EL-OJO-QUE-TODO-LO-VE-FINAL-.jpg',
          ),
          onTap: () {
            selectedResult = suggestionList[index];
            showResults(context);
          },
        );
      },
    );
  }
}
