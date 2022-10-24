class userForumLists {
  final String id;
  final String name;
  final String content;
  // ignore: non_constant_identifier_names
  final String created_at;

  const userForumLists({
    required this.id,
    required this.name,
    required this.content,
    // ignore: non_constant_identifier_names
    required this.created_at,
  });

  static userForumLists fromJson(json) => userForumLists(
        id: json['id'],
        name: json['name'],
        content: json['content'],
        created_at: json['created_at'],
      );
}

class userReplies {
  final String id;
  final String forum_content;
  final String content;
  final String created_at;

  const userReplies({
    required this.id,
    required this.forum_content,
    required this.content,
    required this.created_at,
  });
  static userReplies fromJson(json) => userReplies(
        id: json['id'],
        forum_content: json['forum_content'],
        content: json['content'],
        created_at: json['created_at'],
      );
}
