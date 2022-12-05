import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import '../../back_end/currentUser.dart';
import '../../back_end/userForums.dart';

class repliesEdit extends StatefulWidget {
  const repliesEdit({Key? key}) : super(key: key);

  @override
  State<repliesEdit> createState() => _repliesEditState();
}

class _repliesEditState extends State<repliesEdit> {
  bool tappedYes = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController editContent = new TextEditingController();
  late Future<List<userReplies>> futureUserReplies = getUserReplies();

  @override
  void initState() {
    super.initState();
    futureUserReplies = getUserReplies();
  }

  static Future<List<userReplies>> getUserReplies() async {
    const url =
        'https://generic-ais.online/backend_app/forum/fetchUserReplies.php';
    final response =
        await http.post(Uri.parse(url), body: {"user_id": CurrentUser.id});
    final body = jsonDecode(response.body);
    return body.map<userReplies>(userReplies.fromJson).toList();
  }

  Future deletePost(String passID) async {
    const url =
        'https://generic-ais.online/backend_app/forum/repliesDelete.php';
    final response =
        await http.post(Uri.parse(url), body: {"reply_id": passID});
    final body = jsonDecode(response.body);
    Fluttertoast.showToast(
        msg: "Post Deleted",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM);
    RefreshFeed();
  }

  /*Future EditPost(String passID) async {
    const url = 'https://10.0.2.2/backend_app/feed/deleteFeed.php';
    final response = await http.post(Uri.parse(url), body: {"user_id": passID});
    final body = jsonDecode(response.body);
    Fluttertoast.showToast(
        msg: "Post Deleted",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM);
    RefreshFeed();
  }*/

  Future<void> RefreshFeed() async {
    setState(() {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (a, b, c) => repliesEdit(),
              transitionDuration: Duration(seconds: 2)));
    });
  }

  Future updateReply(String passID, String updatedContent) async {
    const url = 'https://generic-ais.online/backend_app/forum/editReplies.php';
    final response = await http.post(Uri.parse(url),
        body: {"reply_id": passID, "update": updatedContent});

    final body = jsonDecode(response.body);
    Fluttertoast.showToast(
        msg: "Reply Updated",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM);
    RefreshFeed();
  }

  Future editReply(String replyID, String prefilledBody) async {
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
                      updateReply(replyID, passPrefilledBody.text);
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

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Replies'),
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: RefreshJob,
          child: Center(
            child: FutureBuilder<List<userReplies>>(
              future: futureUserReplies,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else if (snapshot.hasData) {
                  final repliesUser = snapshot.data!;
                  return buildview(repliesUser);
                } else {
                  return const Text("No User Data");
                }
              },
            ),
          ),
        ));
  }

  Widget buildview(List<userReplies> repliesUser) => ListView.builder(
      itemCount: repliesUser.length,
      itemBuilder: (context, index) {
        int reverseIndex = repliesUser.length - 1 - index;

        final replyUser = repliesUser[reverseIndex];

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
                          replyUser.forum_content,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 40),
                              Text(
                                "You Replied:" + replyUser.content,
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
                                        await editReply(
                                            replyUser.id, replyUser.content);
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
                                            await ReplyDialogs.yesAbortDialog(
                                                context,
                                                "Delete this post?",
                                                replyUser.content);
                                        if (action == DialogAction.yes) {
                                          setState(() => tappedYes = true);
                                          deletePost(replyUser.id);
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
                                    replyUser.created_at,
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
              pageBuilder: (a, b, c) => repliesEdit(),
              transitionDuration: Duration(seconds: 2)));
    });
  }
}

enum DialogAction { yes, abort }

class ReplyDialogs {
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
