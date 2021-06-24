import 'dart:convert';

AuthModelMe authModelMeFromJson(String str) =>
    AuthModelMe.fromJson(json.decode(str));

String authModelMeToJson(AuthModelMe data) => json.encode(data.toJson());

class AuthModelMe {
  AuthModelMe({
    this.country,
    this.displayName,
    this.email,
    this.explicitContent,
    this.externalUrls,
    this.followers,
    this.href,
    this.id,
    this.images,
    this.product,
    this.type,
    this.uri,
  });

  String country;
  String displayName;
  String email;
  ExplicitContent explicitContent;
  ExternalUrls externalUrls;
  Followers followers;
  String href;
  String id;
  List<Image> images;
  String product;
  String type;
  String uri;

  factory AuthModelMe.fromJson(Map<String, dynamic> json) => AuthModelMe(
        country: json["country"],
        displayName: json["display_name"],
        email: json["email"],
        explicitContent: ExplicitContent.fromJson(json["explicit_content"]),
        externalUrls: ExternalUrls.fromJson(json["external_urls"]),
        followers: Followers.fromJson(json["followers"]),
        href: json["href"],
        id: json["id"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        product: json["product"],
        type: json["type"],
        uri: json["uri"],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "display_name": displayName,
        "email": email,
        "explicit_content": explicitContent.toJson(),
        "external_urls": externalUrls.toJson(),
        "followers": followers.toJson(),
        "href": href,
        "id": id,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "product": product,
        "type": type,
        "uri": uri,
      };
}

class ExplicitContent {
  ExplicitContent({
    this.filterEnabled,
    this.filterLocked,
  });

  bool filterEnabled;
  bool filterLocked;

  factory ExplicitContent.fromJson(Map<String, dynamic> json) =>
      ExplicitContent(
        filterEnabled: json["filter_enabled"],
        filterLocked: json["filter_locked"],
      );

  Map<String, dynamic> toJson() => {
        "filter_enabled": filterEnabled,
        "filter_locked": filterLocked,
      };
}

class ExternalUrls {
  ExternalUrls({
    this.spotify,
  });

  String spotify;

  factory ExternalUrls.fromJson(Map<String, dynamic> json) => ExternalUrls(
        spotify: json["spotify"],
      );

  Map<String, dynamic> toJson() => {
        "spotify": spotify,
      };
}

class Followers {
  Followers({
    this.href,
    this.total,
  });

  dynamic href;
  int total;

  factory Followers.fromJson(Map<String, dynamic> json) => Followers(
        href: json["href"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
        "total": total,
      };
}

class Image {
  Image({
    this.height,
    this.url,
    this.width,
  });

  dynamic height;
  String url;
  dynamic width;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        height: json["height"],
        url: json["url"],
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "height": height,
        "url": url,
        "width": width,
      };
}
