import 'dart:convert';

import 'package:flutter_application_1/src/models/auth_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:oauth2_client/github_oauth2_client.dart';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:oauth2_client/oauth2_helper.dart';

class AuthProvider {
  Future<Map<String, dynamic>> authGitHub() async {
    OAuth2Client hlp = GitHubOAuth2Client(
      redirectUri: dotenv.env['REDIRECT_URI'],
      customUriScheme: dotenv.env['CUSTOM_URI_SCHEMA'],
    );

    OAuth2Helper oauth2Helper = OAuth2Helper(
      hlp,
      grantType:
          OAuth2Helper.AUTHORIZATION_CODE, //default value, can be omitted
      clientId: dotenv.env['CLIENT_ID'],
      clientSecret: dotenv.env['CLIENT_SECRET'],
      scopes: ['user'],
    );

    final resp = await oauth2Helper.get('https://api.github.com/user');

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    if (!decodedData.containsKey('message')) {
      // _prefs.tokenUser = decodedData[tknResp.accessToken];

      return {'ok': true, 'username': decodedData['login']};
    } else {
      return {'ok': false, 'mensaje': decodedData['message']};
    }
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
