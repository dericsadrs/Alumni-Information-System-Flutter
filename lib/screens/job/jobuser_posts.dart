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
  bool tappedYes = false;
  late Future<List<FeedEditDelete>> futureUserJobs = getUserJob();

  @override
  void initState() {
    super.initState();
    futureUserJobs = getUserJob();
  }

  static Future<List<FeedEditDelete>> getUserJob() async {
    const url = 'https://generic-ais.online/backend_app/jobs/fetchUserJob.php';
    final response =
        await http.post(Uri.parse(url), body: {"user_id": CurrentUser.id});
    final body = jsonDecode(response.body);
    return body.map<FeedEditDelete>(FeedEditDelete.fromJson).toList();
  }

  Future deletePost(String passID) async {
    const url = 'https://generic-ais.online/backend_app/jobs/deleteJob.php';
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
          title: const Text('Your Job Posts'),
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
                  title: Column(children: [
                    Row(
                      children: [
                        Text(
                          jobUser.title,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    )
                  ]),
                  subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        Text(
                          jobUser.content,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            TextButton(
                                onPressed: null,
                                child: Text(
                                  "Edit",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.blue),
                                )),
                            SizedBox(
                              width: 20,
                            ),
                            TextButton(
                                onPressed: null,
                                child: Text(
                                  "Delete",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.blue),
                                ))
                          ],
                        ),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              jobUser.created_at,
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.bold),
                            )),
                      ])),
            )));
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

enum DialogAction { yes, abort }

class JobDialogs {
  static Future<DialogAction> yesAbortDialog(
    BuildContext context,
    String title,
    String body,
  ) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(title),
          content: Text(body),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(DialogAction.abort),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(DialogAction.yes),
              child: const Text(
                'Yes',
              ),
            ),
          ],
        );
      },
    );
    return (action != null) ? action : DialogAction.abort;
  }
}
