import 'dart:convert';

import 'package:alumni_sandbox/back_end/alumniUser.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'alumni_profile.dart';

class Alumni extends StatefulWidget {
  const Alumni({Key? key}) : super(key: key);

  @override
  State<Alumni> createState() => _AlumniState();
}

class _AlumniState extends State<Alumni> {
  late Future<List<AlumniUser>> alumniFuture = getAlumni();

  @override
  void initState() {
    super.initState();
    alumniFuture = getAlumni();
  }

  static Future<List<AlumniUser>> getAlumni() async {
    const url = 'https://generic-ais.online//backend_app/alumni/getAlumni.php';
    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body);
    return body.map<AlumniUser>(AlumniUser.fromJson).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alumni'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: new Icon(Icons.person_search_rounded),
            onPressed: () {
              Navigator.pushNamed(context, "/findalumni");
            },
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder<List<AlumniUser>>(
          future: alumniFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (snapshot.hasData) {
              final alumnis = snapshot.data!;

              return buildview(alumnis);
            } else {
              return const Text("No User Data");
            }
          },
        ),
      ),
    );
  }

  Widget buildview(List<AlumniUser> alumnis) => ListView.builder(
      itemCount: alumnis.length,
      itemBuilder: (context, index) {
        final user = alumnis[index];

        return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AlumniProfile(
                            title: user.title,
                            full_name: user.full_name,
                            university: user.university,
                            course_name: user.course,
                            email_address: user.email_address,
                            gender: user.gender,
                            address: user.address,
                            contact_number: user.contact_number,
                            civil_status: user.civil_status,
                            job_business: user.job_business,
                            business_address: user.business_address,
                            high_school: user.high_school,
                            high_school_yg: user.high_school_yg,
                            senior_highschool: user.senior_highschool,
                            senior_highschool_yg: user.senior_highschool_yg,
                            college_batch: user.college_batch,
                            birthday: user.birthday,
                            nickname: user.nickname,
                            image_path: user.image_path,
                          )));
            },
            child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                    padding: EdgeInsets.all(12),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Icon(Icons.person),
                      ), //child: Image(image: AssetImage(user.image_path))),
                      trailing: Icon(Icons.keyboard_arrow_right_rounded),
                      title: Text(
                        user.full_name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        user.course,
                      ),
                      dense: true,
                    ))));
      });
}
