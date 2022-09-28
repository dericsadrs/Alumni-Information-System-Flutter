import 'dart:convert';

import 'package:alumni_sandbox/back_end/joblists.dart';
import 'package:alumni_sandbox/back_end/joblists.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Job extends StatefulWidget {
  const Job({Key? key}) : super(key: key);

  @override
  State<Job> createState() => _JobState();
}

class _JobState extends State<Job> {
  late Future<List<JobsLists>> futureJobs = getJobs();
  @override
  void initState() {
    super.initState();
    futureJobs = getJobs();
  }

  static Future<List<JobsLists>> getJobs() async {
    const url = 'https://192.168.0.110/backend_app/getJobs.php';
    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body);
    return body.map<JobsLists>(JobsLists.fromJson).toList();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alumni'),
        actions: [IconButton(onPressed: null, icon: Icon(Icons.search))],
      ),
      body: Center(
        child: FutureBuilder<List<JobsLists>>(
          future: futureJobs,
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

  Widget buildview(List<JobsLists> alumnis) => ListView.builder(
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
                      leading: CircleAvatar(),
                      trailing: Icon(Icons.keyboard_arrow_right_rounded),
                      title: Text(
                        user.job_title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(user.job_description),
                      dense: true,
                    ))));
      });
}
