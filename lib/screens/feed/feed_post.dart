import 'dart:convert';

import 'package:alumni_sandbox/back_end/currentUser.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class FeedPost extends StatefulWidget {
  const FeedPost({Key? key}) : super(key: key);

  @override
  State<FeedPost> createState() => _FeedPostState();
}

class _FeedPostState extends State<FeedPost> {
  TextEditingController content = new TextEditingController();

  Future addPost() async {
    final response = await http.post(
        Uri.parse("https://10.0.2.2/backend_app/feed/postFeed.php"),
        body: {
          "id": CurrentUser.id,
          "content": content.text,
        });
    var postFeed = jsonDecode(response.body);

    if (postFeed == true) {
      Fluttertoast.showToast(
          msg: "Succesfully Posted",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    } else if (postFeed == false) {
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
          title: Text('Feed Post'),
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
                          controller: content,
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
