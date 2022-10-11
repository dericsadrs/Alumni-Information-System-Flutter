class ForumLists {
  final String id;
  // ignore: non_constant_identifier_names
  final String user_id;
  final String name;
  final String content;
  // ignore: non_constant_identifier_names
  final String date_published;

  const ForumLists({
    required this.id,
    required this.user_id,
    required this.name,
    required this.content,
    // ignore: non_constant_identifier_names
    required this.date_published,
  });

  static ForumLists fromJson(json) => ForumLists(
        id: json['id'],
        user_id: json['user_id'],
        name: json['name'],
        content: json['content'],
        date_published: json['date_published'],
      );
}

class ReplyLists {
  final String name;
  final String reply;
  // ignore: non_constant_identifier_names
  final String date_published;

  const ReplyLists({
    required this.name,
    required this.reply,
    required this.date_published,
  });
  static ReplyLists fromJson(json) => ReplyLists(
        name: json['name'],
        reply: json['reply'],
        date_published: json['date_published'],
      );
}
