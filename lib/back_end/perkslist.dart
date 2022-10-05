class PerksList {
  final String content;
  final String date_published;

  const PerksList({
    required this.date_published,
    required this.content,
  });

  static PerksList fromJson(json) => PerksList(
      content: json['content'], date_published: json['date_published']);
}
