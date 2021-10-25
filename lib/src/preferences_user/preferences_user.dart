import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET

  get tokenUser {
    return _prefs.getString('tokenUser') ?? '';
  }

  set tokenUser(String value) {
    _prefs.setString('tokenUser', value);
  }

  get tokenRefresh {
    return _prefs.getString('tokenRefresh') ?? '';
  }

  set tokenRefresh(String value) {
    _prefs.setString('tokenRefresh', value);
  }

  // GET y SET de la última página
  get ultimaPagina {
    return _prefs.getString('ultimaPagina') ?? 'login';
  }

  set ultimaPagina(String value) {
    _prefs.setString('ultimaPagina', value);
  }

  get idPlayList {
    return _prefs.getString('idPlayList') ?? '5tyneaeBQREnBe06qagqwO';
  }

  set idPlayList(String value) {
    _prefs.setString('idPlayList', value);
  }
}
