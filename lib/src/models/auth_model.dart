import 'dart:convert';

AuthModel authModelFromJson(String str) => AuthModel.fromJson(json.decode(str));

String authModelToJson(AuthModel data) => json.encode(data.toJson());

class AuthModel {
  AuthModel({
    this.message,
    this.login,
    this.name,
    this.username,
    this.email,
    this.avatarUrl,
    this.htmlUrl,
  });
  String message;
  String login;
  String name;
  String username;
  String email;
  String avatarUrl;
  String htmlUrl;

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
      login: json["login"],
      name: json["name"],
      username: json["username"],
      email: json["email"],
      avatarUrl: json["avatar_url"],
      htmlUrl: json["htmlUrl"],
      message: json["message"]);

  Map<String, dynamic> toJson() => {
        "login": login,
        "name": name,
        "username": username,
        "email": email,
        "avatar_url": avatarUrl,
        "htmlUrl": htmlUrl,
        "message": message
      };
}
