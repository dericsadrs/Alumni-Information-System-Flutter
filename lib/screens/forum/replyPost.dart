import 'dart:convert';

import 'package:alumni_sandbox/back_end/currentUser.dart';
import 'package:alumni_sandbox/screens/forum/replies.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ReplyPost extends StatefulWidget {
  final String name;
  final String question;
  final String question_id;

  const ReplyPost({
    Key? key,
    // ignore: non_constant_identifier_names
    required this.question_id,
    required this.name,
    required this.question,
  }) : super(key: key);

  @override
  State<ReplyPost> createState() => _ReplyPostState();
}

class _ReplyPostState extends State<ReplyPost> {
  TextEditingController contentReply = new TextEditingController();

  Future addReply() async {
    final response = await http.post(
        Uri.parse("https://generic-ais.online/backend_app/forum/postReply.php"),
        body: {
          "user_id": CurrentUser.id,
          "question_id": widget.question_id,
          "reply": contentReply.text,
        });
    var replyPost = jsonDecode(response.body);
    if (replyPost == true) {
      Fluttertoast.showToast(
          msg: "Succesfully Posted",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
          Navigator.pop(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Replies(question_id: widget.question_id, name: widget.name, question: widget.question,
                          
                          )));
    } else if (replyPost == false) {
      Fluttertoast.showToast(
          msg: "Oops Something went wrong ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Reply to a Question'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          SizedBox(
            height: 40,
          ),
          Text(widget.question),
          Row(
            children: [
              SizedBox(
                height: 40,
                width: 40,
              ),
              Text("Replying as:  "),
              Text(CurrentUser.full_name),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ), // BoxDecoration
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        height: 100,
                      ), // Container
                    ),
                    Expanded(
                      child: TextFormField(
                          controller: contentReply,
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: null,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: ' Express your thoughts')),
                    ),
                  ],
                )),
          ),
          SizedBox(
            height: 25,
          ),
          GestureDetector(
              onTap: () {
                addReply();
              },
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100.0),
                  child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 0, 119, 255),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                          child: Text("Post",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              )))))),
        ])));
  }
}
