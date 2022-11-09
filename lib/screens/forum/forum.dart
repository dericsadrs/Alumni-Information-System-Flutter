import 'dart:convert';

import 'package:alumni_sandbox/back_end/forumLists.dart';
import 'package:alumni_sandbox/screens/forum/replies.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../../back_end/currentUser.dart';

class Forum extends StatefulWidget {
  const Forum({Key? key}) : super(key: key);

  @override
  State<Forum> createState() => _ForumState();
}

class _ForumState extends State<Forum> {
  late Future<List<ForumLists>> ForumFuture = getForum();

  @override
  void initState() {
    super.initState();
    ForumFuture = getForum();
  }

  static Future<List<ForumLists>> getForum() async {
    const url = 'https://generic-ais.online/backend_app/forum/getQuestions.php';
    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body);
    return body.map<ForumLists>(ForumLists.fromJson).toList();
  }

  Future<void> RefreshForum() async {
    setState(() {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (a, b, c) => Forum(),
              transitionDuration: Duration(seconds: 2)));
      Fluttertoast.showToast(
          msg: "Refreshed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, "/postquestion");
          },
          label: const Text('Post a Question'),
          icon: const Icon(Icons.add_comment),
        ),
        appBar: AppBar(
          title: Text('Forum'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: new Icon(Icons.delete),
              onPressed: () {
                Navigator.pushNamed(context, "/userforums");
              },
            ),
          ],
        ),
        body: Center(
          child: RefreshIndicator(
            onRefresh: RefreshForum,
            child: FutureBuilder<List<ForumLists>>(
              future: ForumFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else if (snapshot.hasData) {
                  final Forums = snapshot.data!;
                  return buildview(Forums);
                } else {
                  return const Text("No User Data");
                }
              },
            ),
          ),
        ));
  }

  Widget buildview(List<ForumLists> forumQuestions) => ListView.builder(
      itemCount: forumQuestions.length,
      itemBuilder: (context, index) {
        int reverseIndex = forumQuestions.length - 1 - index;
        final question = forumQuestions[reverseIndex];

        return GestureDetector(
            onTap: () {
              null;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Replies(
                            question_id: question.id,
                            name: question.name,
                            question: question.content,
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
                        //isThreeLine: true,
                        /* trailing: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Replies(
                                        question_id: question.id,
                                        name: question.name,
                                        question: question.content)));
                          },*
                          child: Text("Open"),
                        ),*/
                        title: Row(children: [
                          Text(
                            question.name,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 110,
                          ),
                        ]),
                        subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                question.content,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    question.created_at,
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )
                            ])))));
      });
}
