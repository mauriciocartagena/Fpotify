import 'dart:convert';

import 'package:flutter_application_1/src/models/play_list_model.dart';
import 'package:flutter_application_1/src/preferences_user/preferences_user.dart';
import 'package:http/http.dart' as http;

Future<List<AuthModelPLayList>> playList() async {
  final prefs = new PreferenciasUsuario();

  final url = 'https://api.spotify.com/v1/me/playlists';

  final resp = await http.get(Uri.parse(url),
      headers: {'Authorization': ' Bearer ${prefs.tokenUser}'});

  if (resp.statusCode == 200) {
    final Map<String, dynamic> decodeData = jsonDecode(resp.body);

    final List<AuthModelPLayList> playListUser = [];

    if (decodeData == null) return [];

    final playList = AuthModelPLayList.fromJson(decodeData);

    playListUser.add(playList);

    return playListUser;
  } else {
    return [];
  }
}

listPlayList(String id, limit, offset) async {
  final prefs = PreferenciasUsuario();

  final resp = await http.get(
    Uri.parse(
      'https://api.spotify.com/v1/playlists/$id/tracks?market=ES&limit=${limit}&offset=${offset}',
    ),
    headers: {'Authorization': 'Bearer ${prefs.tokenUser}'},
  );

  print(resp);
}
