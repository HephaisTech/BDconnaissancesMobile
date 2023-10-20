import 'dart:convert';

class Tags {
  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  Pivot pivot;

  Tags({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  Tags copyWith({
    int? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
    Pivot? pivot,
  }) =>
      Tags(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        pivot: pivot ?? this.pivot,
      );

  factory Tags.fromRawJson(String str) => Tags.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Tags.fromJson(Map<String, dynamic> json) => Tags(
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
