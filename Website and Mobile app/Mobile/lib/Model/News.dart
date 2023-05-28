import 'dart:convert';

News newsFromJson(String str) => News.fromJson(json.decode(str));

String newsToJson(News data) => json.encode(data.toJson());

class News {
  News({
    required this.news,
  });

  List<NewsElement> news;

  factory News.fromJson(Map<String, dynamic> json) => News(
    news: List<NewsElement>.from(json["news"].map((x) => NewsElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "news": List<dynamic>.from(news.map((x) => x.toJson())),
  };
}

class NewsElement {
  NewsElement({
    required this.id,
    required this.name,
    required this.image,
    required this.content,
    required this.createdAt,
    required this.gambarfix,
  });

  String id;
  String name;
  String image;
  String content;
  DateTime createdAt;
  String gambarfix;

  factory NewsElement.fromJson(Map<String, dynamic> json) => NewsElement(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    content: json["content"],
    createdAt: DateTime.parse(json["created_at"]),
    gambarfix: json["gambarfix"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "content": content,
    "created_at": createdAt.toIso8601String(),
    "gambarfix": gambarfix,
  };
}
