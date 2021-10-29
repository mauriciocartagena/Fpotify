import 'package:flutter_application_1/src/models/search_model.dart';
import 'package:flutter_application_1/src/preferences_user/preferences_user.dart';
import 'package:dio/dio.dart';

search(String type, String query, int limit) async {
  final prefs = PreferenciasUsuario();

  final _dio = new Dio();

  try {
    final resp = await _dio.get(
      'https://api.spotify.com/v1/search',
      queryParameters: {'q': '$query', 'limit': '$limit', 'type': '$type'},
      options: Options(
        headers: {'Authorization': 'Bearer ${prefs.tokenUser}'},
      ),
    );

    final Map<String, dynamic> music = resp.data;

    final name = SearchModel.fromJson(music);

    return name.tracks.items.toList();
  } catch (e) {
    print(e);
    return [];
  }
}
