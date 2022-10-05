import 'dart:convert';

import 'package:alumni_sandbox/back_end/coursesLists.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Courses extends StatefulWidget {
  const Courses({Key? key}) : super(key: key);

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  late Future<List<CoursesLists>> futureCoursess = getCourses();

  @override
  void initState() {
    super.initState();
    futureCoursess = getCourses();
  }

  static Future<List<CoursesLists>> getCourses() async {
    const url = 'https://192.168.0.110/backend_app/courses/getCourses.php';
    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body);
    return body.map<CoursesLists>(CoursesLists.fromJson).toList();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses'),
        centerTitle: true,
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(90),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
            )),
      ),
      body: Center(
        child: FutureBuilder<List<CoursesLists>>(
          future: futureCoursess,
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

  Widget buildview(List<CoursesLists> alumnis) => ListView.builder(
      itemCount: alumnis.length,
      itemBuilder: (context, index) {
        final user = alumnis[index];

        return GestureDetector(
            onTap: () {},
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: EdgeInsets.all(12),
                child: ListTile(
                  title: Text(
                    user.course_name,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  dense: true,
                ),
              ),
            ));
      });
}
