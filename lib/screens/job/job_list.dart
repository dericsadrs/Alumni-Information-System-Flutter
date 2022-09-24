import 'package:flutter/material.dart';

class JobList extends StatelessWidget {
  const JobList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Title Here'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Infomartion here'),
      ),
    );
  }
}
