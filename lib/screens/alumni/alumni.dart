import 'package:flutter/material.dart';

class Alumni extends StatelessWidget {
  const Alumni({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Alumni'),
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
                            Navigator.pushNamed(context, "/alumni_profile");
                          },
                          dense: true,
                          leading: CircleAvatar(),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          title: Text(
                            "Alumni Name",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(" Course and Email"))));
            }));
  }
}
