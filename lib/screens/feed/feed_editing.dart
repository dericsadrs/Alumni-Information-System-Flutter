import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:alumni_sandbox/back_end/feedEditDelete.dart';
import 'package:flutter/material.dart';

import '../../back_end/currentUser.dart';

class FeedEdit extends StatefulWidget {
  const FeedEdit({Key? key}) : super(key: key);

  @override
  State<FeedEdit> createState() => _FeedEditState();
}

class _FeedEditState extends State<FeedEdit> {
  bool tappedYes = false;
  TextEditingController editContent = new TextEditingController();
  late Future<List<FeedEditDelete>> futureUserFeed = getUserFeed();

  @override
  void initState() {
    super.initState();
    futureUserFeed = getUserFeed();
  }

  static Future<List<FeedEditDelete>> getUserFeed() async {
    const url = 'https://generic-ais.online/backend_app/feed/fetchUserFeed.php';
    final response =
        await http.post(Uri.parse(url), body: {"user_id": CurrentUser.id});
    final body = jsonDecode(response.body);
    return body.map<FeedEditDelete>(FeedEditDelete.fromJson).toList();
  }

  Future deletePost(String passID) async {
    const url = 'https://generic-ais.online/backend_app/feed/deleteFeed.php';
    final response = await http.post(Uri.parse(url), body: {"user_id": passID});
    final body = jsonDecode(response.body);
    Fluttertoast.showToast(
        msg: "Post Deleted",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM);
    RefreshFeed();
  }

  /*Future EditPost(String passID) async {
    const url = 'https://generic-ais.online/backend_app/feed/deleteFeed.php';
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
              pageBuilder: (a, b, c) => FeedEdit(),
              transitionDuration: Duration(seconds: 2)));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Posts'),
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: RefreshJob,
          child: Center(
            child: FutureBuilder<List<FeedEditDelete>>(
              future: futureUserFeed,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else if (snapshot.hasData) {
                  final userFeeds = snapshot.data!;
                  return buildview(userFeeds);
                } else {
                  return const Text("No User Data");
                }
              },
            ),
          ),
        ));
  }

  Widget buildview(List<FeedEditDelete> userFeeds) => ListView.builder(
      itemCount: userFeeds.length,
      itemBuilder: (context, index) {
        int reverseIndex = userFeeds.length - 1 - index;

        final userFeed = userFeeds[reverseIndex];

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
                        title: Column(children: [
                          Row(
                            children: [
                              Text(
                                userFeed.title,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          )
                        ]),
                        subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 5),
                              Text(
                                userFeed.content,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  TextButton(
                                      onPressed: null,
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
                                            await Dialogs.yesAbortDialog(
                                                context,
                                                "Delete this post?",
                                                userFeed.content);
                                        if (action == DialogAction.yes) {
                                          setState(() => tappedYes = true);
                                          deletePost(userFeed.id);
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
                                    userFeed.created_at,
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
              pageBuilder: (a, b, c) => FeedEdit(),
              transitionDuration: Duration(seconds: 2)));
    });
  }
}

enum DialogAction { yes, abort }

class Dialogs {
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
