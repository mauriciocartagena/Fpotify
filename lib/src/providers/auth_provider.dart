import 'dart:async';
import 'dart:convert';

import 'package:flutter_application_1/src/models/auth_model_me.dart';
import 'package:flutter_application_1/src/models/auth_model_spotify.dart';
import 'package:flutter_application_1/src/preferences_user/preferences_user.dart';
import 'package:flutter_application_1/src/utills/spotify_oauth2_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:oauth2_client/oauth2_helper.dart';

Future<Map<String, dynamic>> authenticate() async {
  final prefs = new PreferenciasUsuario(); //

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
      'user-follow-read',
      'user-follow-modify',
      'user-modify-playback-state',
      'user-top-read',
      'user-library-read',
      'user-read-playback-position',
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
          {
            'AccessToken': value.accessToken,
            'RefreshToken': value.refreshToken
          },
        ),
      );

  final userTemp = AuthModelSpotify.fromJson(token[0]);

  final List<AuthModelSpotify> user = [];

  user.add(userTemp);

  prefs.tokenUser = user[0].accessToken;
  prefs.tokenRefresh = user[0].refreshToken;

  // print(user[0].accessToken);

  if (user.isNotEmpty) {
    return {'ok': true, 'accessToken': true};
  } else {
    return {'ok': false, 'error': 'Try Again'};
  }
}

Future<List<AuthModelMe>> me() async {
  final prefs = new PreferenciasUsuario();

  final me = await http.get(Uri.parse('https://api.spotify.com/v1/me'),
      headers: {'Authorization': 'Bearer ${prefs.tokenUser}'});
  if (me.statusCode == 401) {
    updateToken();
  }
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

updateToken() async {
  final prefs = PreferenciasUsuario();

  String basicAuth = 'Basic ' +
      base64Encode(
        utf8.encode(
            '${dotenv.env['CLIENT_ID_SPOTIFY']}:${dotenv.env['SECRET_ID']}'),
      );

  final url = await http
      .post(Uri.parse('https://accounts.spotify.com/api/token'), body: {
    'grant_type': 'refresh_token',
    'refresh_token': prefs.tokenRefresh
  }, headers: {
    'Authorization': basicAuth
  });

  // print(url.body);

  if (url.statusCode == 200) {
    final Map<String, dynamic> decodeData = jsonDecode(url.body);

    if (decodeData == null) return [];
    prefs.tokenUser = decodeData['access_token'];
    prefs.tokenRefresh = decodeData['refresh_token'];
  }
}
