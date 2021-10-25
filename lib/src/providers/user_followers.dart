import 'dart:convert';
// import 'dart:io';

import 'package:flutter_application_1/src/models/follower_model.dart';
import 'package:flutter_application_1/src/preferences_user/preferences_user.dart';
import 'package:http/http.dart' as http;

Future<List<FollowerModel>> getFollowers() async {
  final prefs = new PreferenciasUsuario();
  final queryParameters = {
    'type': 'artist',
  };
  final uri =
      Uri.https('api.spotify.com', '/v1/me/following/', queryParameters);

  final response = await http.get(
    uri,
    headers: {'Authorization': 'Bearer ${prefs.tokenUser}'},
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> decodeData = jsonDecode(response.body);

    final List<FollowerModel> follower = [];

    if (decodeData == null) return [];

    final fromJson = FollowerModel.fromJson(decodeData);

    follower.add(fromJson);

    return follower;
  } else {
    return [];
  }
}
