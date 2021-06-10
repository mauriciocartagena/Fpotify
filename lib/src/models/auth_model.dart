import 'dart:convert';

AuthModel authModelFromJson(String str) => AuthModel.fromJson(json.decode(str));

String authModelToJson(AuthModel data) => json.encode(data.toJson());

class AuthModel {
  AuthModel({
    this.login,
    this.name,
    this.username,
    this.email,
    this.avatarUrl,
  });

  String login;
  String name;
  String username;
  String email;
  String avatarUrl;

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        login: json["login"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        avatarUrl: json["avatar_url"],
      );

  Map<String, dynamic> toJson() => {
        "login": login,
        "name": name,
        "username": username,
        "email": email,
        "avatar_url": avatarUrl,
      };
}
