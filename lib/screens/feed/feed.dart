import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  State<Feed> createState() => _LoginState();
}

// Instance of the Stateful Widget
class _LoginState extends State<Feed> {
  List postList = [];

  getPostList() async {
    var response = await http
        .get(Uri.parse("https://192.168.0.110/backend_app/getpost.php"));
    if (response.statusCode == 200) {
      setState(() {
        postList = jsonDecode(response.body);
      });
      print(postList.length);
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, "/post");
          },
          child: Icon(Icons.feed),
        ),
        appBar: AppBar(
          title: const Text("Feed"),
          centerTitle: true,
        ),
        body: ListView.builder(
            itemCount: postList.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                      padding: EdgeInsets.all(12),
                      child: ListTile(
                        leading: CircleAvatar(),
                        title: Text(
                          "Name Here",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          postList[index]['content'],
                        ),
                        dense: true,
                      )));
            }));
  }
}
