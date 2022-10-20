class PerksList {
  final String content;
  final String created_at;

  const PerksList({
    required this.created_at,
    required this.content,
  });

  static PerksList fromJson(json) =>
      PerksList(content: json['content'], created_at: json['created_at']);
}
