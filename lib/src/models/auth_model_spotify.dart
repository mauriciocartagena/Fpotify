import 'dart:convert';

AuthModelSpotify authModelSpotifyFromJson(String str) =>
    AuthModelSpotify.fromJson(json.decode(str));

String authModelSpotifyToJson(AuthModelSpotify data) =>
    json.encode(data.toJson());

class AuthModelSpotify {
  AuthModelSpotify({
    this.accessToken,
    this.refreshToken,
  });

  String accessToken;
  String refreshToken;

  factory AuthModelSpotify.fromJson(Map<String, dynamic> json) =>
      AuthModelSpotify(
        accessToken: json["AccessToken"],
        refreshToken: json["RefreshToken"],
      );

  Map<String, dynamic> toJson() => {
        "AccessToken": accessToken,
        "RefreshToken": refreshToken,
      };
}
