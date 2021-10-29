import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/pages/account/account.dart';
import 'package:flutter_application_1/src/pages/home/home_page.dart';
import 'package:flutter_application_1/src/pages/play_list/listview_page.dart';
import 'package:flutter_application_1/src/pages/play_music/play_music.dart';
import 'package:flutter_application_1/src/pages/search/search.dart';
import 'package:flutter_application_1/src/preferences_user/preferences_user.dart';

class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int _selectedIndex = 0;
  final prefs = new PreferenciasUsuario();

  Map<String, int> _routers = {
    'home': 0,
    'play_list': 1,
    'play': 2,
    'search': 3,
    'account': 4,
  };

  @override
  void initState() {
    super.initState();

    String prefsLastPage = prefs.ultimaPagina;

    if (prefsLastPage == 'Index') {
      String lastPage = 'home';

      _selectedIndex = _routers[lastPage];
    }
    String lastPage = prefsLastPage;
    // Verificar la preferencia de la ultimaPagina que pasa

    _selectedIndex = _routers[lastPage];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _paginas = [
    ListaPage(),
    HomePage(),
    PlayMusic(),
    SearchPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _paginas[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music),
            label: 'Music Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_play),
            label: 'Play List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_arrow),
            label: 'Play',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          )
        ],
        currentIndex: _selectedIndex,
        backgroundColor: Color.fromRGBO(26, 26, 29, 1),
        selectedItemColor: Colors.white,
        unselectedItemColor: Color.fromRGBO(157, 158, 163, 1),
        onTap: _onItemTapped,
      ),
    );
  }
}
