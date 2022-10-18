import 'dart:convert';

import 'package:alumni_sandbox/back_end/currentUser.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Question extends StatefulWidget {
  const Question({Key? key}) : super(key: key);

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  TextEditingController question = new TextEditingController();

  Future addPost() async {
    final response = await http.post(
        Uri.parse("https://10.0.2.2/backend_app/forum/postQuestion.php"),
        body: {"user_id": CurrentUser.id, "question": question.text});
    var postQuestion = jsonDecode(response.body);

    if (postQuestion == true) {
      Fluttertoast.showToast(
          msg: "Succesfully Posted",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    } else if (postQuestion == false) {
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
          title: Text('Post a Question'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              SizedBox(
                width: 38,
              ),
              Text("Posting as:  "),
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
                          controller: question,
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: null,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: ' Announce Something')),
                    ),
                  ],
                )),
          ),
          SizedBox(
            height: 25,
          ),
          GestureDetector(
              onTap: () {
                addPost();
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
