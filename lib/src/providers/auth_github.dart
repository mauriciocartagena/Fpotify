import 'package:oauth2_client/github_oauth2_client.dart';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:oauth2_client/oauth2_helper.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Oauth2ClientExample {
  Future<void> fetchFiles() async {
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
    print(resp.body);
  }
}
