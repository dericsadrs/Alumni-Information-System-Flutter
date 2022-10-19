class FeedList {
  final String title;
  final String content;
  final String name;
  final String created_at;

  const FeedList({
    // ignore: non_constant_identifier_names
    required this.title,
    required this.created_at,
    required this.name,
    required this.content,
  });

  static FeedList fromJson(json) => FeedList(
        title: json['title'],
        content: json['content'],
        name: json['name'],
        created_at: json['created_at'],
      );
}
