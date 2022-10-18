class JobsLists {
  final String name;
  final String content;
  final String date_published;

  const JobsLists({
    required this.name,
    required this.content,
    required this.date_published,
  });

  static JobsLists fromJson(json) => JobsLists(
        name: json['name'],
        content: json['content'],
        date_published: json['date_published'],
      );
}
