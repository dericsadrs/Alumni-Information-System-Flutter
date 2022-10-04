import 'dart:convert';

import 'package:alumni_sandbox/back_end/currentUser.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class YourProfile extends StatefulWidget {
  const YourProfile({Key? key}) : super(key: key);

  @override
  State<YourProfile> createState() => _YourProfileState();
}

class _YourProfileState extends State<YourProfile> {
  late Future<List<CurrentUser>> YourProfileFuture = getCurrentUser();

  @override
  void initState() {
    super.initState();
    YourProfileFuture = getCurrentUser();
  }

  static Future<List<CurrentUser>> getCurrentUser() async {
    const url = 'https://192.168.0.110/backend_app/user/userLogin.php';
    final response = await http.get(Uri.parse(url));
    print(response.body);
    final body = jsonDecode(response.body);
    return body.map<CurrentUser>(CurrentUser.fromJson).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('YourProfile'),
        centerTitle: true,
        actions: [IconButton(onPressed: null, icon: Icon(Icons.search))],
      ),
      body: Center(
        child: FutureBuilder<List<CurrentUser>>(
          future: YourProfileFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (snapshot.hasData) {
              final YourProfiles = snapshot.data!;
              return buildview(YourProfiles);
            } else {
              return const Text("No User Data");
            }
          },
        ),
      ),
    );
  }

  Widget buildview(List<CurrentUser> YourProfiles) => ListView.builder(
      itemCount: YourProfiles.length,
      itemBuilder: (context, index) {
        final user = YourProfiles[index];

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
                      trailing: Icon(Icons.keyboard_arrow_right_rounded),
                      title: Text(
                        user.full_name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        user.course_name,
                      ),
                      dense: true,
                    ))));
      });
}
