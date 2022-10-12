class JobEditDelete {
  final String id;

  final String content;
  final String date_published;
  const JobEditDelete({
    required this.id,
    required this.date_published,
    required this.content,
  });

  static JobEditDelete fromJson(json) => JobEditDelete(
      id: json['id'],
      content: json['content'],
      date_published: json['date_published']);
}
