import 'dart:convert';

import 'package:alumni_sandbox/back_end/feedlists.dart';
import 'package:flutter/material.dart';
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
    const url = 'https://192.168.0.110/backend_app/Feed/getFeed.php';
    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body);
    return body.map<FeedList>(FeedList.fromJson).toList();
  }

  @override
  Widget buildview(List<FeedList> Feeds) => ListView.builder(
      itemCount: Feeds.length,
      itemBuilder: (context, index) {
        final user_feeds = Feeds[index];

        return GestureDetector(
            onTap: () {},
            child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                    padding: EdgeInsets.all(12),
                    child: ListTile(
                      leading: CircleAvatar(),
                      title: Text(
                        user_feeds.name,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        user_feeds.content,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ))));
      });

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, "/jobpost");
        },
        label: const Text('Write Something'),
        icon: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Feed'),
        centerTitle: true,
      ),
      body: Center(
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
    );
  }
}
