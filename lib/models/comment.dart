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

  Commentaire({
    required this.id,
    required this.articleId,
    required this.authorId,
    required this.content,
    required this.withfile,
    required this.upvotes,
    required this.createdAt,
    required this.updatedAt,
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
      };
}
