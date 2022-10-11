import 'dart:convert';

import 'package:alumni_sandbox/back_end/forumLists.dart';
import 'package:alumni_sandbox/screens/forum/replies.dart';
import 'package:flutter/material.dart';
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
    const url = 'https://192.168.0.110/backend_app/Forum/getQuestions.php';
    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body);
    return body.map<ForumLists>(ForumLists.fromJson).toList();
  }

  /* Future addPost() async {
    final response = await http.post(
        Uri.parse("https://192.168.0.110/backend_app/feed/postFeed.php"),
        body: {
          "user_id": CurrentUser.id;
        });*/

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
      appBar: AppBar(title: Text('Forum'), centerTitle: true),
      body: Center(
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
    );
  }

  Widget buildview(List<ForumLists> forumQuestions) => ListView.builder(
      itemCount: forumQuestions.length,
      itemBuilder: (context, index) {
        final question = forumQuestions[index];

        return GestureDetector(
            onTap: () {
              null;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Replies(
                            question_id: question.id,
                            user_id: question.user_id,
                            name: question.name,
                            date_published: question.date_published,
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
                      leading: CircleAvatar(),

                      title: Row(children: [
                        Text(
                          question.name,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 110,
                        ),
                        Text(
                          question.date_published,
                          style: TextStyle(fontSize: 11),
                        )
                      ]),

                      subtitle: Text(
                        question.content,
                        style: TextStyle(fontSize: 13),
                      ),

                      dense: true,
                    ))));
      });
}
