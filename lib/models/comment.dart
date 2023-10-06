import 'dart:convert';

class Commentaire {
  int id;
  int articleId;
  String authorId;
  String content;
  String withfile;
  int upvotes;
  DateTime createdAt;
  DateTime updatedAt;
  Author author;

  Commentaire({
    required this.id,
    required this.articleId,
    required this.authorId,
    required this.content,
    required this.withfile,
    required this.upvotes,
    required this.createdAt,
    required this.updatedAt,
    required this.author,
  });

  Commentaire copyWith({
    int? id,
    int? articleId,
    String? authorId,
    String? content,
    String? withfile,
    int? upvotes,
    DateTime? createdAt,
    DateTime? updatedAt,
    Author? author,
  }) =>
      Commentaire(
        id: id ?? this.id,
        articleId: articleId ?? this.articleId,
        authorId: authorId ?? this.authorId,
        content: content ?? this.content,
        withfile: withfile ?? this.withfile,
        upvotes: upvotes ?? this.upvotes,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        author: author ?? this.author,
      );

  factory Commentaire.fromRawJson(String str) =>
      Commentaire.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Commentaire.fromJson(Map<String, dynamic> json) => Commentaire(
        id: json["id"],
        articleId: json["article_id"],
        authorId: json["author_id"],
        content: json["content"],
        withfile: json["withfile"],
        upvotes: json["upvotes"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        author: Author.fromJson(json["author"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "article_id": articleId,
        "author_id": authorId,
        "content": content,
        "withfile": withfile,
        "upvotes": upvotes,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "author": author.toJson(),
      };
}

class Author {
  String id;
  String name;
  String email;
  String phone;
  String latit;
  String longit;
  DateTime emailVerifiedAt;
  dynamic photo;
  DateTime createdAt;
  DateTime updatedAt;

  Author({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.latit,
    required this.longit,
    required this.emailVerifiedAt,
    required this.photo,
    required this.createdAt,
    required this.updatedAt,
  });

  Author copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? latit,
    String? longit,
    DateTime? emailVerifiedAt,
    dynamic photo,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Author(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        latit: latit ?? this.latit,
        longit: longit ?? this.longit,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        photo: photo ?? this.photo,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Author.fromRawJson(String str) => Author.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        latit: json["latit"],
        longit: json["longit"],
        emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
        photo: json["photo"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "latit": latit,
        "longit": longit,
        "email_verified_at": emailVerifiedAt.toIso8601String(),
        "photo": photo,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
