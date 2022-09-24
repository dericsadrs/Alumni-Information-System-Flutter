import 'package:flutter/material.dart';

class Job extends StatelessWidget {
  const Job({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, "/jobpost");
          },
          child: Icon(Icons.feed),
        ),
        appBar: AppBar(
          title: Text('Job'),
          centerTitle: true,
        ),
        body: ListView.builder(
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  elevation: 3.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                      padding: EdgeInsets.all(12),
                      child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(context, "/joblist");
                          },
                          dense: true,
                          trailing: Icon(Icons.keyboard_arrow_right),
                          title: Text(
                            "Job Title Here",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                              " LOOKING FOR EXPERIENCED FLUTTER DEVELOPER"))));
            }));
  }
}
