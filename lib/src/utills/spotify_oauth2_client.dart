import 'package:oauth2_client/oauth2_client.dart';

class SpotifyOAuth2Client extends OAuth2Client {
  SpotifyOAuth2Client({String redirectUri, String customUriScheme})
      : super(
          authorizeUrl: 'https://accounts.spotify.com/authorize',
          tokenUrl: 'https://accounts.spotify.com/api/token',
          redirectUri: redirectUri,
          customUriScheme: customUriScheme,
        );
}
