import 'dart:convert';
import 'package:alumni_sandbox/back_end/currentUser.dart';
import 'package:alumni_sandbox/back_end/joblists.dart';
import 'package:alumni_sandbox/screens/login.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Job extends Login {
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
    const url = 'https://192.168.0.110/backend_app/jobs/getJobs.php';
    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body);
    return body.map<JobsLists>(JobsLists.fromJson).toList();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jobs'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, "/jobpost");
        },
        label: const Text('Post A Job'),
        icon: const Icon(Icons.add),
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
              CurrentUser().displayData();

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
                  trailing: TextButton(
                    onPressed: () {},
                    child: Text("Apply"),
                  ),
                  title: Text(
                    user.name,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    user.content,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  dense: true,
                ),
              ),
            ));
      });
}
