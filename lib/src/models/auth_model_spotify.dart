import 'dart:convert';

AuthModelSpotify authModelSpotifyFromJson(String str) =>
    AuthModelSpotify.fromJson(json.decode(str));

String authModelSpotifyToJson(AuthModelSpotify data) =>
    json.encode(data.toJson());

class AuthModelSpotify {
  AuthModelSpotify({
    this.accessToken,
  });

  String accessToken;

  factory AuthModelSpotify.fromJson(Map<String, dynamic> json) =>
      AuthModelSpotify(
        accessToken: json["AccessToken"],
      );

  Map<String, dynamic> toJson() => {
        "AccessToken": accessToken,
      };
}
