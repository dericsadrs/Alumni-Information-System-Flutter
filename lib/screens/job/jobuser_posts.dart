import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:alumni_sandbox/back_end/feedEditDelete.dart';
import 'package:flutter/material.dart';

import '../../back_end/currentUser.dart';

class EditJob extends StatefulWidget {
  const EditJob({Key? key}) : super(key: key);

  @override
  State<EditJob> createState() => _FeedEditState();
}

class _FeedEditState extends State<EditJob> {
  late Future<List<FeedEditDelete>> futureUserJobs = getUserJob();

  @override
  void initState() {
    super.initState();
    futureUserJobs = getUserJob();
  }

  static Future<List<FeedEditDelete>> getUserJob() async {
    const url = 'https://10.0.2.2/backend_app/jobs/fetchUserJob.php';
    final response =
        await http.post(Uri.parse(url), body: {"user_id": CurrentUser.id});
    final body = jsonDecode(response.body);
    return body.map<FeedEditDelete>(FeedEditDelete.fromJson).toList();
  }

  Future deletePost(String passID) async {
    const url = 'https://10.0.2.2/backend_app/jobs/deleteJob.php';
    final response = await http.post(Uri.parse(url), body: {"user_id": passID});
    final body = jsonDecode(response.body);
    Fluttertoast.showToast(
        msg: "Post Deleted",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM);
    RefreshFeed();
  }

  Future<void> RefreshFeed() async {
    setState(() {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (a, b, c) => EditJob(),
              transitionDuration: Duration(seconds: 2)));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Posts'),
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: RefreshJob,
          child: Center(
            child: FutureBuilder<List<FeedEditDelete>>(
              future: futureUserJobs,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else if (snapshot.hasData) {
                  final userJobs = snapshot.data!;
                  return buildview(userJobs);
                } else {
                  return const Text("No User Data");
                }
              },
            ),
          ),
        ));
  }

  Widget buildview(List<FeedEditDelete> userJobs) => ListView.builder(
      itemCount: userJobs.length,
      itemBuilder: (context, index) {
        int reverseIndex = userJobs.length - 1 - index;

        final jobUser = userJobs[reverseIndex];

        return GestureDetector(
            onTap: () {},
            child: Card(
              /* elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),*/
              child: Padding(
                padding: EdgeInsets.all(12),
                child: ListTile(
                  trailing: Column(children: [
                    TextButton(
                      onPressed: () {
                        deletePost(jobUser.id);
                      },
                      child: Text("Delete"),
                    ),
                  ]),
                  title: Text(
                    jobUser.title,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  subtitle: Text(
                    jobUser.content,
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
              pageBuilder: (a, b, c) => EditJob(),
              transitionDuration: Duration(seconds: 2)));
    });
  }
}
