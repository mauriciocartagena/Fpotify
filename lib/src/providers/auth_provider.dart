import 'dart:async';
import 'dart:convert';

import 'package:flutter_application_1/src/models/auth_model_me.dart';
import 'package:flutter_application_1/src/models/auth_model_spotify.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:oauth2_client/google_oauth2_client.dart';
import 'package:oauth2_client/oauth2_helper.dart';

Future<Map<String, dynamic>> authenticate() async {
  SpotifyOAuth2Client client = SpotifyOAuth2Client(
    redirectUri: 'Fpotify://oauth2redirect',
    customUriScheme: 'Fpotify',
  );

  OAuth2Helper auth2helper = OAuth2Helper(
    client,
    grantType: OAuth2Helper.AUTHORIZATION_CODE,
    clientId: dotenv.env['CLIENT_ID_SPOTIFY'],
    clientSecret: dotenv.env['SECRET_ID'],
    scopes: [
      'playlist-read-private',
      'playlist-read-collaborative',
      'playlist-modify-public',
      'playlist-modify-private',
      'user-read-recently-played',
      'user-top-read',
      'user-read-playback-position',
      'user-read-playback-state',
      'user-modify-playback-state',
      'user-read-currently-playing',
      'user-read-email',
      'user-read-private'
    ],
  );

  final token = [];

  await auth2helper.getToken().then(
        (value) => token.add(
          {'AccessToken': value.accessToken},
        ),
      );

  final userTemp = AuthModelSpotify.fromJson(token[0]);

  final List<AuthModelSpotify> user = [];

  user.add(userTemp);

  if (user.isNotEmpty) {
    return {'ok': true, 'accessToken': user[0].accessToken};
  } else {
    return {'ok': false, 'error': 'Try Again'};
  }
}

Future<List<AuthModelMe>> me(String token) async {
  final me =
      await http.get(Uri.parse('https://api.spotify.com/v1/me'), headers: {
    'Authorization': 'Bearer $token',
  });

  if (me.statusCode == 200) {
    final Map<String, dynamic> decodeData = jsonDecode(me.body);

    final List<AuthModelMe> user = [];

    if (decodeData == null) return [];

    final userMe = AuthModelMe.fromJson(decodeData);

    user.add(userMe);

    return user;
  } else {
    return [];
  }
}
