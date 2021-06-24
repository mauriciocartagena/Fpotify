import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/pages/account/account.dart';
import 'package:flutter_application_1/src/pages/home/home_page.dart';
import 'package:flutter_application_1/src/pages/play_list/listview_page.dart';
import 'package:flutter_application_1/src/pages/search/search.dart';
import 'package:flutter_application_1/src/preferences_user/preferences_user.dart';
import 'package:flutter_application_1/src/providers/auth_provider.dart';

class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int _selectedIndex = 0;

  final prefs = new PreferenciasUsuario();

  Map<String, int> _routers = {
    'home': 0,
    'search': 1,
    'play_list': 2,
    'account': 3,
  };

  @override
  void initState() {
    super.initState();

    authenticate();
    String lastPage = prefs.ultimaPagina;

    _selectedIndex = _routers[lastPage];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _paginas = [
    HomePage(),
    SearchPage(),
    ListaPage(),
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
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music),
            label: 'Music Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Your Account',
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
