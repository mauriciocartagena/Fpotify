import 'dart:convert';

FollowerModel followerModelFromJson(String str) =>
    FollowerModel.fromJson(json.decode(str));

String followerModelToJson(FollowerModel data) => json.encode(data.toJson());

class FollowerModel {
  FollowerModel({
    this.artists,
  });

  Artists artists;

  factory FollowerModel.fromJson(Map<String, dynamic> json) => FollowerModel(
        artists: Artists.fromJson(json["artists"]),
      );

  Map<String, dynamic> toJson() => {
        "artists": artists.toJson(),
      };
}

class Artists {
  Artists({
    this.items,
    this.next,
    this.total,
    this.cursors,
    this.limit,
    this.href,
  });

  List<Item> items;
  dynamic next;
  int total;
  Cursors cursors;
  int limit;
  String href;

  factory Artists.fromJson(Map<String, dynamic> json) => Artists(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        next: json["next"],
        total: json["total"],
        cursors: Cursors.fromJson(json["cursors"]),
        limit: json["limit"],
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "next": next,
        "total": total,
        "cursors": cursors.toJson(),
        "limit": limit,
        "href": href,
      };
}

class Cursors {
  Cursors({
    this.after,
  });

  dynamic after;

  factory Cursors.fromJson(Map<String, dynamic> json) => Cursors(
        after: json["after"],
      );

  Map<String, dynamic> toJson() => {
        "after": after,
      };
}

class Item {
  Item({
    this.externalUrls,
    this.followers,
    this.genres,
    this.href,
    this.id,
    this.images,
    this.name,
    this.popularity,
    this.type,
    this.uri,
  });

  ExternalUrls externalUrls;
  Followers followers;
  List<String> genres;
  String href;
  String id;
  List<Image> images;
  String name;
  int popularity;
  String type;
  String uri;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        externalUrls: ExternalUrls.fromJson(json["external_urls"]),
        followers: Followers.fromJson(json["followers"]),
        genres: List<String>.from(json["genres"].map((x) => x)),
        href: json["href"],
        id: json["id"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        name: json["name"],
        popularity: json["popularity"],
        type: json["type"],
        uri: json["uri"],
      );

  Map<String, dynamic> toJson() => {
        "external_urls": externalUrls.toJson(),
        "followers": followers.toJson(),
        "genres": List<dynamic>.from(genres.map((x) => x)),
        "href": href,
        "id": id,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "name": name,
        "popularity": popularity,
        "type": type,
        "uri": uri,
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

  int height;
  String url;
  int width;

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
