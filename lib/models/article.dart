import 'dart:convert';

class Article {
  int id;
  String title;
  String departement;
  String project;
  String content;
  String withfile;
  String authorId;
  DateTime createdAt;
  DateTime updatedAt;
  int commentCount;

  Article({
    required this.id,
    required this.title,
    required this.departement,
    required this.project,
    required this.content,
    required this.withfile,
    required this.authorId,
    required this.createdAt,
    required this.updatedAt,
    required this.commentCount,
  });

  Article copyWith({
    int? id,
    String? title,
    String? departement,
    String? project,
    String? content,
    String? withfile,
    String? authorId,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? commentCount,
  }) =>
      Article(
        id: id ?? this.id,
        title: title ?? this.title,
        departement: departement ?? this.departement,
        project: project ?? this.project,
        content: content ?? this.content,
        withfile: withfile ?? this.withfile,
        authorId: authorId ?? this.authorId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        commentCount: commentCount ?? this.commentCount,
      );

  factory Article.fromRawJson(String str) => Article.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        id: json["id"],
        title: json["title"],
        departement: json["departement"],
        project: json["project"],
        content: json["content"],
        withfile: json["withfile"],
        authorId: json["author_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        commentCount: json["comment_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "departement": departement,
        "project": project,
        "content": content,
        "withfile": withfile,
        "author_id": authorId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "comment_count": commentCount,
      };
}
