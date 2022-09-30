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
        title: const Text('Alumni Profile'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  "assets/images/background-1.png"))),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Center(
                  child: Column(children: [
                Text(
                  full_name,
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  email_address,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ])),
              SizedBox(
                height: 25,
              ),
              ListTile(
                leading: Icon(Icons.account_balance_sharp),
                title: Text(university),
              ),
              ListTile(
                leading: Icon(Icons.school),
                title: Text(course_name),
                subtitle: Text("Year Graduated: " + college_batch),
              ),
              ListTile(
                leading: Icon(Icons.corporate_fare),
                title: Text(job_business),
              ),
              ListTile(
                leading: Icon(Icons.pin_drop),
                title: Text(business_address),
              ),
              ListTile(
                leading: Icon(Icons.contact_mail),
                title: Text(
                  address,
                ),
                subtitle: Text(contact_number),
              ),
              Divider(
                height: 40,
              ),
              Text("Education: "),
              ListTile(
                leading: Icon(Icons.school),
                title: Text("Senior High: " + senior_highschool),
                subtitle: Text("Year Graduated: " + senior_highschool_yg),
              ),
              ListTile(
                leading: Icon(Icons.school),
                title: Text("Junior High: " + high_school),
                subtitle: Text("Year Graduated: " + high_school_yg),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
