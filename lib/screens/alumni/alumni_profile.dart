import 'package:flutter/material.dart';

class AlumniProfile extends StatelessWidget {
  const AlumniProfile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alumni Profile'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Infomartion here'),
      ),
    );
  }
}
