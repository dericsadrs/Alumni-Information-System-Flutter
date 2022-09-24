import 'package:flutter/material.dart';

class Forum extends StatelessWidget {
  const Forum({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Forum'),
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
                            Navigator.pushNamed(context, "/Forum");
                          },
                          dense: true,
                          trailing: Icon(Icons.keyboard_arrow_right),
                          title: Text(
                            "Forum Title Here",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                              " LOOKING FOR EXPERIENCED FLUTTER DEVELOPER"))));
            }));
  }
}
