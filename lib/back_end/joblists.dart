class JobsLists {
  final String name;
  final String content;
  final String email_address;

  const JobsLists({
    required this.name,
    required this.content,
    required this.email_address,
  });

  static JobsLists fromJson(json) => JobsLists(
        name: json['name'],
        content: json['content'],
        email_address: json['email_address'],
      );
}
