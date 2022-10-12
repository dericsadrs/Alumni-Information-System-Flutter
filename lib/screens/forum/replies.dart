import 'dart:convert';

import 'package:alumni_sandbox/back_end/forumLists.dart';
import 'package:alumni_sandbox/screens/forum/replyPost.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import '../../back_end/currentUser.dart';

class Replies extends StatefulWidget {
  final String name;
  final String question;
  final String question_id;

  const Replies({
    Key? key,
    // ignore: non_constant_identifier_names
    required this.question_id,
    required this.name,
    required this.question,
  }) : super(key: key);

  @override
  State<Replies> createState() => _RepliesState();
}

class _RepliesState extends State<Replies> {
  late Future<List<ReplyLists>> replyFuture = fetchReplies();
  TextEditingController reply = new TextEditingController();
  @override
  void initState() {
    super.initState();
    replyFuture = fetchReplies();
  }

  Future<List<ReplyLists>> fetchReplies() async {
    final response = await http.post(
      Uri.parse("https://192.168.0.110/backend_app/forum/getReplies.php"),
      body: {
        "question_id": widget.question_id,
      },
    );
    final body = jsonDecode(response.body);
    return body.map<ReplyLists>(ReplyLists.fromJson).toList();
  }

  /* Future addQuestion() async {
    final response = await http.post(
        Uri.parse("https://192.168.0.110/backend_app/feed/postFeed.php"),
        body: {
          "id": CurrentUser.id,
          "question_id": widget.question_id,
          "content": reply.text,
        });
    var postFeed = jsonDecode(response.body);

    if (postFeed == true) {
      Fluttertoast.showToast(
          msg: "You've Replied to the question",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    } else if (postFeed == false) {
      Fluttertoast.showToast(
          msg: "Oops Something went wrong ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ReplyPost(
                        question_id: widget.question_id,
                        name: widget.name,
                        question: widget.question,
                      )));
        },
        label: const Text('Write'),
        icon: const Icon(Icons.add_comment),
      ),
      appBar: AppBar(
        title: Text('Replies'),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<List<ReplyLists>>(
          future: replyFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (snapshot.hasData) {
              final repliesLists = snapshot.data!;
              return buildview(repliesLists);
            } else {
              return const Text("No User Data");
            }
          },
        ),
      ),
    );
  }

  Widget buildview(List<ReplyLists> repliesLists) => ListView.builder(
      itemCount: repliesLists.length,
      itemBuilder: (context, index) {
        final reply = repliesLists[index];

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
                        //isThreeLine: true,

                        title: Row(children: [
                          Text(
                            "Replied by:",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            reply.name,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ]),
                        subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                reply.reply,
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [Text(reply.date_published)],
                              )
                            ])))));
      });
}
