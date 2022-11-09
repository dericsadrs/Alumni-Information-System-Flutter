import 'dart:convert';

import 'package:alumni_sandbox/back_end/feedlists.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  // ignore: non_constant_identifier_names
  late Future<List<FeedList>> FeedFuture = getFeed();

  @override
  void initState() {
    super.initState();
    FeedFuture = getFeed();
  }

  static Future<List<FeedList>> getFeed() async {
    const url = 'https://generic-ais.online/backend_app/feed/getFeed.php';
    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body);

    return body.map<FeedList>(FeedList.fromJson).toList();
  }

  @override
  Widget buildview(List<FeedList> Feeds) => ListView.builder(
      itemCount: Feeds.length,
      itemBuilder: (context, index) {
        int reverseIndex = Feeds.length - 1 - index;

        final user_feeds = Feeds[reverseIndex];

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
                        leading: CircleAvatar(
                          child: Icon(Icons.person),
                        ),
                        title: Text(
                          user_feeds.name,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 5),
                              Text(
                                user_feeds.title,
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5),
                              Text(
                                user_feeds.content,
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    user_feeds.created_at,
                                    style: TextStyle(fontSize: 11),
                                  )
                                ],
                              )
                            ])))));
      });

  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, "/feedpost");
          },
          label: const Text('Write'),
          icon: const Icon(Icons.add_comment),
        ),
        appBar:
            AppBar(title: Text('Feed'), centerTitle: true, actions: <Widget>[
          IconButton(
            icon: new Icon(Icons.edit_note),
            onPressed: () {
              Navigator.pushNamed(context, "/feededit");
            },
          ),
        ]),
        body: Center(
          child: RefreshIndicator(
            onRefresh: RefreshFeed,
            child: FutureBuilder<List<FeedList>>(
              future: FeedFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else if (snapshot.hasData) {
                  final feeds = snapshot.data!;
                  return buildview(feeds);
                } else {
                  return const Text("No User Data");
                }
              },
            ),
          ),
        ));
  }

  Future<void> RefreshFeed() async {
    setState(() {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (a, b, c) => Feed(),
              transitionDuration: Duration(seconds: 2)));
      Fluttertoast.showToast(
          msg: "Refreshed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    });
  }
}
