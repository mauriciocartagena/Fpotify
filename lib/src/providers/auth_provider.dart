import 'dart:convert';

import 'package:flutter_application_1/src/models/auth_model.dart';
import 'package:http/http.dart' as http;

class AuthProvider {
  final String _url = 'https://api.github.com';

  Future<Map<String, dynamic>> cargarInformacion(username) async {
    final url = '$_url/users/$username';

    final resp = await http.get(Uri.parse(url));

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    // print(user[0].message);
    if (!decodedData.containsKey('message')) {
      return {'ok': true, 'username': decodedData['login']};
    } else {
      return {'ok': false, 'mensaje': decodedData['message']};
    }
  }

  Future<List<AuthModel>> cargarFollow() async {
    final url = '$_url/users/mauriciocartagena/following';

    final resp = await http.get(Uri.parse(url));

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<AuthModel> user = [];

    if (decodedData == null) return [];

    final userTemp = AuthModel.fromJson(decodedData);

    user.add(userTemp);

    // print(user[0].login);
    return user;
  }
}
