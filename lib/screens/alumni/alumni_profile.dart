import 'package:flutter/material.dart';

class AlumniProfile extends StatefulWidget {
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

  const AlumniProfile(
      {Key? key,
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
      required this.image_path})
      : super(key: key);

  @override
  State<AlumniProfile> createState() => _AlumniProfileState();
}

class _AlumniProfileState extends State<AlumniProfile> {
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
            children: <Widget>[
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
                              image: NetworkImage(
                                  "https://generic-ais.online/storage/${widget.image_path}"))),
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
                  widget.full_name,
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  widget.email_address,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ])),
              SizedBox(
                height: 25,
              ),
              ListTile(
                leading: SizedBox(
                    height: 30.0,
                    width: 55.0, // fixed width and height
                    child: Image.asset("assets/images/uni.png")),
                title: Text(widget.university),
              ),
              ListTile(
                leading: SizedBox(
                    height: 30.0,
                    width: 55.0, // fixed width and height
                    child: Image.asset("assets/images/graduation.png")),
                title: Text(widget.course_name),
                subtitle: Text("Year Graduated: " + widget.college_batch),
              ),
              ListTile(
                leading: SizedBox(
                    height: 30.0,
                    width: 55.0, // fixed width and height
                    child: Image.asset("assets/images/job.png")),
                title: Text(widget.job_business),
                subtitle: Text(widget.business_address),
              ),
              ListTile(
                leading: SizedBox(
                    height: 30.0,
                    width: 55.0, // fixed width and height
                    child: Image.asset("assets/images/gender.png")),
                title: Text(widget.civil_status),
                subtitle: Text(widget.gender),
              ),
              /*ListTile(
                leading: Icon(Icons.contact_mail),
                title: Text(
                  widget.address,
                ),
                subtitle: Text(widget.contact_number),
              ),*/
              /* Divider(
                height: 40,
              ),
              Text("Education: "),
              ListTile(
                leading: Icon(Icons.school),
                title: Text("Senior High: " + widget.senior_highschool),
                subtitle:
                    Text("Year Graduated: " + widget.senior_highschool_yg),
              ),
              ListTile(
                leading: Icon(Icons.school),
                title: Text("Junior High: " + widget.high_school),
                subtitle: Text("Year Graduated: " + widget.high_school_yg),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
