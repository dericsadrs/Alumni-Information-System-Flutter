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
