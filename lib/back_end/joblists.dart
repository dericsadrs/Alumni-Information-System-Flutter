class JobsLists {
  final String id;
  // final String alumni_id;
  // final String uni_admin_id;
  final String job_title;
  final String job_description;

  const JobsLists({
    required this.id,
    // required this.alumni_id,
    // required this.uni_admin_id,
    required this.job_title,
    required this.job_description,
  });

  static JobsLists fromJson(json) => JobsLists(
        id: json['id'],
        // alumni_id: json['alumni_id'],
        //  uni_admin_id: json['uni_admin_id'],
        job_title: json['job_title'],
        job_description: json['job_description'],
      );
}
