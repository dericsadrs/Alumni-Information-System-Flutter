class JobEditDelete {
  final String id;
  final String title;
  final String content;
  final String address;
  final String created_at;

  const JobEditDelete({
    required this.id,
    required this.title,
    required this.content,
    required this.address,
    required this.created_at,
  });

  static JobEditDelete fromJson(json) => JobEditDelete(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      address: json['address'],
      created_at: json['created_at']);
}
