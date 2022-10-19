class JobsLists {
  final String email;
  final String name;
  final String title;
  final String content;
  final String address;
  final String created_at;

  const JobsLists({
    required this.email,
    required this.name,
    required this.title,
    required this.content,
    required this.address,
    required this.created_at,
  });

  static JobsLists fromJson(json) => JobsLists(
      email: json['email'],
      name: json['name'],
      title: json['title'],
      content: json['content'],
      address: json['address'],
      created_at: json['created_at']);
}
