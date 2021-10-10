import 'dart:async';
import 'package:rxdart/rxdart.dart';

class LoginBloc {
  final _usernameGitHubController = BehaviorSubject<String>();
  final _idPlayListController = BehaviorSubject<String>();

  // Recuperar los datos del Stream
  Stream<String> get usernameStream => _usernameGitHubController.stream;

  // Insertar valores al Stream
  Function(String) get changeUsername => _usernameGitHubController.sink.add;

  // Obtener el último valor ingresado a los streams
  String get username => _usernameGitHubController?.value;

  Stream<String> get idPlayListStream => _idPlayListController.stream;

  Function(String) get changeIdPlayList => _idPlayListController.sink.add;

  String get idPlayList => _idPlayListController?.value;

  dispose() {
    _usernameGitHubController?.close();
    _idPlayListController?.close();
  }
}
