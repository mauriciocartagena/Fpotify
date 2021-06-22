# Nos ayudar a poder hacer login con Spotify
	
	class SpotifyOAuth2Client extends OAuth2Client {
	SpotifyOAuth2Client(
	{required String redirectUri, required String customUriScheme})
	: super(
		authorizeUrl: 'https://accounts.spotify.com/authorize',
		tokenUrl: 'https://accounts.spotify.com/api/token',
		redirectUri: redirectUri,
		customUriScheme: customUriScheme,
		);
	}