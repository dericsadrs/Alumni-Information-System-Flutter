import 'package:flutter/material.dart';

class AlumniProfile extends StatelessWidget {
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

  const AlumniProfile({
    Key? key,
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alumni Profile'),
        centerTitle: true,
      ),
  
    );
  }
}
