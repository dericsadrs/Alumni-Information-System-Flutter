// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class CourseDescription extends StatefulWidget {
  final String course;
  final String course_description;

  const CourseDescription({
    Key? key,
    required this.course,
    required this.course_description,
  });

  @override
  State<CourseDescription> createState() => _CourseDescriptionState();
}

class _CourseDescriptionState extends State<CourseDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Description'),
        centerTitle: true,
      ),
      body: Container(
          padding: EdgeInsets.only(left: 16, top: 25, right: 16),
          child: Card(
            elevation: 3,
            /* shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),*/
            child: Padding(
              padding: EdgeInsets.all(12),
              child: ListTile(
                title: Text(
                  widget.course,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                subtitle: Text(
                  widget.course_description,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                dense: true,
              ),
            ),
          )),
    );
  }
}
