class CurrentUser {
  String id;
  /*String title;
  String full_name;
  String university;
  String course_name;
  String email_address;
  String gender;
  String address;
  String contact_number;
  String civil_status;
  String job_business;
  String business_address;
  String high_school;
  String high_school_yg;
  String senior_highschool;
  String senior_highschool_yg;
  String college_batch;
  String birthday;
  String nickname;*/

  CurrentUser({required this.id
      /*this.title,
    this.full_name,
    this.university,
     this.course_name,
     this.email_address,
     this.gender,
     this.address,
     this.contact_number,
     this.civil_status,
     this.job_business,
     this.business_address,
     this.high_school,
     this.high_school_yg,
     this.senior_highschool,
     this.senior_highschool_yg,
     this.college_batch,
     this.birthday,
     this.nickname,*/
      });

  CurrentUser.fromJson(Map<String, dynamic> json) : id = json['id'];
  /* title = json['email'],
        full_name = json['full_name'];*/

  Map<String, dynamic> toJson() => {};
}
