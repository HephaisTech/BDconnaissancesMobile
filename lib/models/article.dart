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
  List<Tag> tags;
  List<Stepvi> steps;

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
    required this.tags,
    required this.steps,
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
    List<Tag>? tags,
    List<Stepvi>? steps,
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
        tags: tags ?? this.tags,
        steps: steps ?? this.steps,
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
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
        steps: List<Stepvi>.from(json["steps"].map((x) => Stepvi.fromJson(x))),
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
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
        "steps": List<dynamic>.from(steps.map((x) => x.toJson())),
      };
}

class Stepvi {
  int id;
  int articleId;
  String description;
  int order;
  String attachedFile;
  DateTime createdAt;
  DateTime updatedAt;

  Stepvi({
    required this.id,
    required this.articleId,
    required this.description,
    required this.order,
    required this.attachedFile,
    required this.createdAt,
    required this.updatedAt,
  });

  Stepvi copyWith({
    int? id,
    int? articleId,
    String? description,
    int? order,
    String? attachedFile,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Stepvi(
        id: id ?? this.id,
        articleId: articleId ?? this.articleId,
        description: description ?? this.description,
        order: order ?? this.order,
        attachedFile: attachedFile ?? this.attachedFile,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Stepvi.fromRawJson(String str) => Stepvi.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Stepvi.fromJson(Map<String, dynamic> json) => Stepvi(
        id: json["id"],
        articleId: json["article_id"],
        description: json["description"],
        order: json["order"],
        attachedFile: json["attached_file"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "article_id": articleId,
        "description": description,
        "order": order,
        "attached_file": attachedFile,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Tag {
  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  Pivot pivot;

  Tag({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  Tag copyWith({
    int? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
    Pivot? pivot,
  }) =>
      Tag(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        pivot: pivot ?? this.pivot,
      );

  factory Tag.fromRawJson(String str) => Tag.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        pivot: Pivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "pivot": pivot.toJson(),
      };
}

class Pivot {
  int articleId;
  int tagId;

  Pivot({
    required this.articleId,
    required this.tagId,
  });

  Pivot copyWith({
    int? articleId,
    int? tagId,
  }) =>
      Pivot(
        articleId: articleId ?? this.articleId,
        tagId: tagId ?? this.tagId,
      );

  factory Pivot.fromRawJson(String str) => Pivot.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        articleId: json["article_id"],
        tagId: json["tag_id"],
      );

  Map<String, dynamic> toJson() => {
        "article_id": articleId,
        "tag_id": tagId,
      };
}
