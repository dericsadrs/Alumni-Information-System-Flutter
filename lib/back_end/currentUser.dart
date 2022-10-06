class CurrentUser {
  static late String id;
  static late String title;
  static late String full_name;
  static late String university;
  static late String course_name;
  static late String email_address;
  static late String gender;
  static late String address;
  static late String contact_number;
  static late String civil_status;
  static late String job_business;
  static late String business_address;
  static late String high_school;
  static late String high_school_yg;
  static late String senior_highschool;
  static late String senior_highschool_yg;
  static late String college_batch;
  static late String birthday;
  static late String nickname;

  void getData(
      id,
      title,
      full_name,
      university,
      course_name,
      email_address,
      gender,
      address,
      contact_number,
      civil_status,
      job_business,
      business_address,
      high_school,
      high_school_yg,
      senior_highschool,
      senior_higschool_yg,
      college_batch,
      birthday,
      nickname) {
    CurrentUser.id = id;
    CurrentUser.title = title;
    CurrentUser.full_name = full_name;
    CurrentUser.university = university;
    CurrentUser.course_name = course_name;
    CurrentUser.email_address = email_address;
    CurrentUser.gender = gender;
    CurrentUser.address = address;
    CurrentUser.contact_number = contact_number;
    CurrentUser.civil_status = civil_status;
    CurrentUser.job_business = job_business;
    CurrentUser.business_address = business_address;
    CurrentUser.high_school = high_school;
    CurrentUser.high_school_yg = high_school;
    CurrentUser.senior_highschool = senior_highschool;
    CurrentUser.senior_highschool_yg = senior_higschool_yg;
    CurrentUser.college_batch = college_batch;
    CurrentUser.birthday = birthday;
    CurrentUser.nickname = nickname;
  }

  void displayData() {
    print(id);
  }
}
