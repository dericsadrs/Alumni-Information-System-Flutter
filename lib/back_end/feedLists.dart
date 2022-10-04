class FeedList {
  final String content;
  final String name;
  final String date_published;
  final String status;

  const FeedList({
    required this.date_published,
    required this.status,
    required this.name,
    required this.content,
  });

  static FeedList fromJson(json) => FeedList(
      content: json['content'],
      name: json['name'],
      date_published: json['date_published'],
      status: json['status']);
}
