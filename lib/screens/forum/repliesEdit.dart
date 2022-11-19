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
    const url = 'https://generic-ais.online/backend_app/forum/repliesDelete.php';
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
                        trailing: Column(children: [
                          TextButton(
                            onPressed:() async{
                            final action = 
                              await ReplyDialogs.yesAbortDialog(context, "Delete this response?", replyUser.content);
                              if (action == DialogAction.yes) {setState(() => tappedYes = true );
                              deletePost(replyUser.id);
                              }
                              else {
                                setState(() => tappedYes = false);
                              }

                            },
                            child: Text("Delete"),
                          ),
                        ]),
                        title: Text(
                          replyUser.forum_content,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text("Your Reply:"),
                              SizedBox(height: 5),
                              Text(
                                replyUser.content,
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5),
                              Text(
                                replyUser.created_at,
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
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
             TextButton (
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