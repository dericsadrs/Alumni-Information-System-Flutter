import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:alumni_sandbox/back_end/currentUser.dart';

class JobPost extends StatefulWidget {
  const JobPost({Key? key}) : super(key: key);

  @override
  State<JobPost> createState() => _JobPostState();
}

class _JobPostState extends State<JobPost> {
  @override
  Widget build(BuildContext context) {
    TextEditingController jobTitle = new TextEditingController();
    TextEditingController jobContent = new TextEditingController();
    TextEditingController jobAddress = new TextEditingController();

    Future addJob() async {
      final response = await http.post(
          Uri.parse("https://generic-ais.online/backend_app/jobs/postJobs.php"),
          body: {
            "id": CurrentUser.id,
            "jobTitle": jobTitle.text,
            "jobAddress": jobAddress.text,
            "jobContent": jobContent.text,
          });
      var postJob = jsonDecode(response.body);
      if (postJob == true) {
        Fluttertoast.showToast(
            msg: "Succesfully Posted",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
        Navigator.pushNamed(context, "/job");
      } else if (postJob == false) {
        Fluttertoast.showToast(
            msg: "Oops Something went wrong ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Job Post'),
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
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
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
                        height: 50,
                      ), // Container
                    ),
                    Expanded(
                      child: TextField(
                          controller: jobTitle,
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 10,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: ' Job Title')),
                    ),
                  ],
                )),
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
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
                        height: 50,
                      ), // Container
                    ),
                    Expanded(
                      child: TextField(
                          controller: jobAddress,
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 10,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: ' Job Address')),
                    ),
                  ],
                )),
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
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
                      child: TextField(
                          controller: jobContent,
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 10,
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
                addJob();
              },
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70.0),
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
