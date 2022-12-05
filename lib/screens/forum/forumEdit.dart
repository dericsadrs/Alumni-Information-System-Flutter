import 'dart:convert';
import 'package:alumni_sandbox/back_end/userForums.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import '../../back_end/currentUser.dart';

class EditForum extends StatefulWidget {
  const EditForum({Key? key}) : super(key: key);

  @override
  State<EditForum> createState() => _EditForumState();
}

class _EditForumState extends State<EditForum> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool tappedYes = false;
  TextEditingController editContent = new TextEditingController();
  late Future<List<userForumLists>> futureUserForum = getUserForum();

  @override
  void initState() {
    super.initState();
    futureUserForum = getUserForum();
  }

  static Future<List<userForumLists>> getUserForum() async {
    const url =
        'https://generic-ais.online/backend_app/forum/fetchUserQuestions.php';
    final response =
        await http.post(Uri.parse(url), body: {"user_id": CurrentUser.id});
    final body = jsonDecode(response.body);
    return body.map<userForumLists>(userForumLists.fromJson).toList();
  }

  Future deletePost(String passID) async {
    const url =
        'https://generic-ais.online/backend_app/forum/deleteQuestion.php';
    final response =
        await http.post(Uri.parse(url), body: {"forum_id": passID});
    final body = jsonDecode(response.body);
    Fluttertoast.showToast(
        msg: "Post Deleted",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM);
    RefreshFeed();
  }

  Future updateForum(String passID, String updatedContent) async {
    const url = 'https://generic-ais.online/backend_app/forum/editForum.php';
    final response = await http.post(Uri.parse(url),
        body: {"forum_id": passID, "update": updatedContent});

    final body = jsonDecode(response.body);
    Fluttertoast.showToast(
        msg: "Question Updated",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM);
    RefreshFeed();
  }

  Future editFeed(String forumID, String prefilledBody) async {
    return await showDialog(
        context: context,
        builder: (context) {
          TextEditingController passPrefilledBody =
              TextEditingController(text: prefilledBody);
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: SingleChildScrollView(
                  child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: passPrefilledBody,
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            maxLines: null,
                            validator: (value) {
                              return value!.isNotEmpty ? null : "Invalid Field";
                            },
                            decoration: InputDecoration(hintText: "Edit"),
                          ),
                        ],
                      ))),
              actions: <Widget>[
                TextButton(
                  child: Text('Save'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Do something like updating SharedPreferences or User Settings etc.
                      updateForum(forumID, passPrefilledBody.text);
                      Navigator.of(context).pop();
                    }
                  },
                ),
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Do something like updating SharedPreferences or User Settings etc.
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          });
        });
  }

  Future<void> RefreshFeed() async {
    setState(() {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (a, b, c) => EditForum(),
              transitionDuration: Duration(seconds: 2)));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, "/userreplies");
          },
          label: const Text('View Replies'),
        ),
        appBar: AppBar(
          title: const Text('Your Questions'),
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: RefreshJob,
          child: Center(
            child: FutureBuilder<List<userForumLists>>(
              future: futureUserForum,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else if (snapshot.hasData) {
                  final userForums = snapshot.data!;
                  return buildview(userForums);
                } else {
                  return const Text("No User Data");
                }
              },
            ),
          ),
        ));
  }

  Widget buildview(List<userForumLists> userForums) => ListView.builder(
      itemCount: userForums.length,
      itemBuilder: (context, index) {
        int reverseIndex = userForums.length - 1 - index;

        final userForum = userForums[reverseIndex];

        return GestureDetector(
            onTap: () {},
            child: Card(
                /*elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),*/
                child: Padding(
                    padding: EdgeInsets.all(12),
                    child: ListTile(
                        title: Text(
                          userForum.name,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 5),
                              Text(
                                userForum.content,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  TextButton(
                                      onPressed: () async {
                                        await editFeed(
                                            userForum.id, userForum.content);
                                      },
                                      child: Text(
                                        "Edit",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.blue),
                                      )),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  TextButton(
                                      onPressed: () async {
                                        final action =
                                            await ForumDialog.yesAbortDialog(
                                                context,
                                                "Delete this post?",
                                                userForum.content);
                                        if (action == DialogAction.yes) {
                                          setState(() => tappedYes = true);
                                          deletePost(userForum.id);
                                        } else {
                                          setState(() => tappedYes = false);
                                        }
                                      },
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
                                    userForum.created_at,
                                    style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ])))));
      });

  Future<void> RefreshJob() async {
    setState(() {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (a, b, c) => EditForum(),
              transitionDuration: Duration(seconds: 2)));
    });
  }
}

enum DialogAction { yes, abort }

class ForumDialog {
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
