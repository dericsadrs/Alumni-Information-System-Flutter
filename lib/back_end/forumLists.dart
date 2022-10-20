class ForumLists {
  final String id;
  final String name;
  final String content;
  // ignore: non_constant_identifier_names
  final String created_at;

  const ForumLists({
    required this.id,
    required this.name,
    required this.content,
    // ignore: non_constant_identifier_names
    required this.created_at,
  });

  static ForumLists fromJson(json) => ForumLists(
        id: json['id'],
        name: json['name'],
        content: json['content'],
        created_at: json['created_at'],
      );
}

class ReplyLists {
  final String id;
  final String name;
  final String content;
  // ignore: non_constant_identifier_names
  final String created_at;

  const ReplyLists({
    required this.id,
    required this.name,
    required this.content,
    // ignore: non_constant_identifier_names
    required this.created_at,
  });
  static ReplyLists fromJson(json) => ReplyLists(
        id: json['id'],
        name: json['name'],
        content: json['content'],
        created_at: json['created_at'],
      );
}
