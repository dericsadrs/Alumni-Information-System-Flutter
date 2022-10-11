class FeedEditDelete {
  final String id;
  final String content;
  final String date_published;

  const FeedEditDelete({
    required this.id,
    required this.date_published,
    required this.content,
  });

  static FeedEditDelete fromJson(json) => FeedEditDelete(
      id: json['id'],
      content: json['content'],
      date_published: json['date_published'],
     
}
