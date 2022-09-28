import 'dart:convert';

import 'package:alumni_sandbox/back_end/alumniUser.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
    const url = 'https://192.168.0.110/backend_app/alumni/getAlumni.php';
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
        actions: [IconButton(onPressed: null, icon: Icon(Icons.search))],
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
              /* Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AlumniProfile(
                            full_name: user.full_name,
                            email_address: user.address,
                            university: user.university,
                            address: user.address,
                            course: user.course,
                            year_graduated: user.year_graduated,
                            civil_status: user.civil_status,
                            job: user.job,
                            title: user.title,
                          )));*/
            },
            child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                    padding: EdgeInsets.all(12),
                    child: ListTile(
                      leading: CircleAvatar(),
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
