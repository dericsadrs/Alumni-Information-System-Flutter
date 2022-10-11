import 'package:flutter/material.dart';

class FeedEdit extends StatefulWidget {
  const FeedEdit({Key? key}) : super(key: key);

  @override
  State<FeedEdit> createState() => _FeedEditState();
}

class _FeedEditState extends State<FeedEdit> {



  Future _login() async {
    final response = await http.post(
      Uri.parse("https://192.168.0.110/backend_app/user/userLogin.php"),
      body: {
        "email_address": email_address.text,
        "password": password.text,
      },
    );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feed Arhcive'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('FeedEdit'),
      ),
    );
    
  }
}
