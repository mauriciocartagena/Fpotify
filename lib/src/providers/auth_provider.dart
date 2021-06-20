import 'dart:async';
import 'dart:convert';

import 'package:flutter_application_1/src/models/auth_model.dart';
import 'package:flutter_application_1/src/models/auth_model_spotify.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:oauth2_client/github_oauth2_client.dart';
import 'package:oauth2_client/google_oauth2_client.dart';
import 'package:oauth2_client/oauth2_client.dart';
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
  );

  final token = [];

  final dataUser =
      await http.get(Uri.parse('https://api.spotify.com/v1/me'), headers: {
    'Authorization':
        'Bearer BQCNbc3MMEWCyrFBRwnsehOUhDnKsS5fBFc_BXl5qiB6fXCHg7fC1rB_qff3WMZs6UCk20W5B_KWWV39LhU3hTBLFyNg_IDCXWby5OmO3mR0cepjuPoexdyNiw6bNqPdk_jdwm9Mu_ugiZJOn15lH9UEJOfccPkWhk_J6A',
  });

  print(dataUser.body);

  await auth2helper.getToken().then(
        (value) => token.add(
          {'AccessToken': value.accessToken},
        ),
      );

  final userTemp = AuthModelSpotify.fromJson(token[0]);

  final List<AuthModelSpotify> user = [];

  user.add(userTemp);

  print(user[0].accessToken);

  if (user.isNotEmpty) {
    return {'ok': true, 'accessToken': user[0].accessToken};
  } else {
    return {'ok': false, 'error': 'Try Again'};
  }
}

Future<List<AuthModel>> me() async {
  OAuth2Client hlp = GitHubOAuth2Client(
    redirectUri: dotenv.env['REDIRECT_URI'],
    customUriScheme: dotenv.env['CUSTOM_URI_SCHEMA'],
  );

  OAuth2Helper oauth2Helper = OAuth2Helper(
    hlp,
    grantType: OAuth2Helper.AUTHORIZATION_CODE, //default value, can be omitted
    clientId: dotenv.env['CLIENT_ID'],
    clientSecret: dotenv.env['CLIENT_SECRET'],
    scopes: ['user'],
  );

  final resp = await oauth2Helper.get('https://api.github.com/user');

  if (resp.statusCode == 200) {
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<AuthModel> user = [];

    if (decodedData == null) return [];

    final userTemp = AuthModel.fromJson(decodedData);

    user.add(userTemp);

    // print(user[0].login);
    return user;
  } else {
    return [];
  }
}
