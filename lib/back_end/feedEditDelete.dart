class FeedEditDelete {
  final String id;
  final String title;
  final String content;
  final String created_at;
  const FeedEditDelete({
    required this.id,
    required this.title,
    required this.content,
    required this.created_at,
  });

  static FeedEditDelete fromJson(json) => FeedEditDelete(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      created_at: json['created_at']);
}
