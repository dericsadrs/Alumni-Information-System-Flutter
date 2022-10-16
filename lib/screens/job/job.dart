import 'dart:convert';
import 'package:alumni_sandbox/back_end/currentUser.dart';
import 'package:alumni_sandbox/back_end/joblists.dart';
import 'package:alumni_sandbox/screens/login.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

//import 'package:url_launcher/url_launcher.dart';

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
          actions: <Widget>[
            IconButton(
              icon: new Icon(Icons.edit_note),
              onPressed: () {
                Navigator.pushNamed(context, "/jobedit");
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, "/jobpost");
          },
          label: const Text('Post A Job'),
          icon: const Icon(Icons.add),
        ),
        body: RefreshIndicator(
          onRefresh: RefreshJob,
          child: Center(
            child: FutureBuilder<List<JobsLists>>(
              future: futureJobs,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else if (snapshot.hasData) {
                  final jobs = snapshot.data!;
                  CurrentUser().displayData();

                  return buildview(jobs);
                } else {
                  return const Text("No User Data");
                }
              },
            ),
          ),
        ));
  }

  Widget buildview(List<JobsLists> jobs) => ListView.builder(
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        int reverseIndex = jobs.length - 1 - index;

        final jobPost = jobs[reverseIndex];

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
                    onPressed: () async {
                      const redirectUrl =
                          "https://mail.google.com/mail/u/0/?fs=1&tf=cm&to=ais@gmail.com";
                      // ignore: deprecated_member_use
                      if (await canLaunch(redirectUrl)) {
                        // ignore: deprecated_member_use
                        await launch(redirectUrl,
                            forceWebView: true, enableJavaScript: true);
                      }
                    },
                    child: Text("Apply"),
                  ),
                  title: Text(
                    jobPost.name,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    jobPost.content,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  dense: true,
                ),
              ),
            ));
      });

  Future<void> RefreshJob() async {
    setState(() {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (a, b, c) => Job(),
              transitionDuration: Duration(seconds: 2)));
    });
  }
}
