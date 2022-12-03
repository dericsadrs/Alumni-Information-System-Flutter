import 'dart:convert';
import 'package:alumni_sandbox/back_end/alumniSearch.dart';
import 'package:alumni_sandbox/back_end/currentUser.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FindAlumni extends StatefulWidget {
  const FindAlumni({Key? key}) : super(key: key);

  @override
  State<FindAlumni> createState() => _FindAlumniState();
}

class _FindAlumniState extends State<FindAlumni> {
  late Future<List<AlumniSearch>> alumniFuture = searchAlumni();
  TextEditingController name = new TextEditingController();

  Future<List<AlumniSearch>> searchAlumni() async {
    const url =
        'https://generic-ais.online/backend_app/alumni/searchAlumni.php';
    final response = await http.post(Uri.parse(url), body: {"name": name.text});
    final body = jsonDecode(response.body);
    print(body);
    return body.map<AlumniSearch>(AlumniSearch.fromJson).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // The search area here
          title: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: TextField(
                  controller: name,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.find_in_page),
                        onPressed: () {
                          searchAlumni();
                        },
                      ),
                      hintText: 'Find an alumni...',
                      border: InputBorder.none),
                ),
              ))),
      body: Center(
        child: FutureBuilder<List<AlumniSearch>>(
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

  Widget buildview(List<AlumniSearch> alumnis) => ListView.builder(
      itemCount: alumnis.length,
      itemBuilder: (context, index) {
        final user = alumnis[index];

        return GestureDetector(
            onTap: () {
              null;
            },
            /*
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AlumniProfile(
                            title: user.title,
                            full_name: user.full_name,
                            university: user.university,
                            course_name: user.course_name,
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
            },*/
            child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                    padding: EdgeInsets.all(12),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/images/profile.png"),
                      ), //child: Image(image: AssetImage(user.image_path))),
                      trailing: Icon(Icons.keyboard_arrow_right_rounded),
                      title: Text(
                        user.full_name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        user.course_name,
                      ),
                      dense: true,
                    ))));
      });
}
