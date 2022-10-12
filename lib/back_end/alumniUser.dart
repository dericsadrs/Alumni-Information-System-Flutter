class AlumniUser {
  final String title;
  final String full_name;
  final String university;
  final String course_name;
  final String email_address;
  final String gender;
  final String address;
  final String contact_number;
  final String civil_status;
  final String job_business;
  final String business_address;
  final String high_school;
  final String high_school_yg;
  final String senior_highschool;
  final String senior_highschool_yg;
  final String college_batch;
  final String birthday;
  final String nickname;
  final String image_path;

  const AlumniUser({
    required this.title,
    required this.full_name,
    required this.university,
    required this.course_name,
    required this.email_address,
    required this.gender,
    required this.address,
    required this.contact_number,
    required this.civil_status,
    required this.job_business,
    required this.business_address,
    required this.high_school,
    required this.high_school_yg,
    required this.senior_highschool,
    required this.senior_highschool_yg,
    required this.college_batch,
    required this.birthday,
    required this.nickname,
    required this.image_path,
  });

  static AlumniUser fromJson(json) => AlumniUser(
        title: json['title'],
        full_name: json['full_name'],
        university: json['university'],
        course_name: json['course_name'],
        email_address: json['email_address'],
        gender: json['gender'],
        address: json['address'],
        contact_number: json['contact_number'],
        civil_status: json['civil_status'],
        job_business: json['job_business'],
        business_address: json['business_address'],
        high_school: json['high_school'],
        high_school_yg: json['high_school_yg'],
        senior_highschool: json['senior_highschool'],
        senior_highschool_yg: json['senior_highschool_yg'],
        college_batch: json['college_batch'],
        birthday: json['birthday'],
        nickname: json['nickname'],
        image_path: json['image_path'],
      );
}
