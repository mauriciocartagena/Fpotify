import 'dart:convert';

AuthModelMe authModelMeFromJson(String str) =>
    AuthModelMe.fromJson(json.decode(str));

String authModelMeToJson(AuthModelMe data) => json.encode(data.toJson());

class AuthModelMe {
  AuthModelMe({
    this.displayName,
    this.images,
  });

  String displayName;
  List<Image> images;

  factory AuthModelMe.fromJson(Map<String, dynamic> json) => AuthModelMe(
        displayName: json["display_name"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "display_name": displayName,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
      };
}

class Image {
  Image({
    this.url,
  });

  String url;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}
