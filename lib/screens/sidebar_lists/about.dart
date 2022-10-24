import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('About'),
          centerTitle: true,
        ),
        body: Container(
            padding: EdgeInsets.only(left: 16, top: 25, right: 16),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: ListView(children: [
                Center(
                  child: Stack(
                    children: [],
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      Divider(),
                      Card(
                        elevation: 3,
                        /*shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),*/
                        child: ListTile(
                          title: Text(
                              "The purpose of this project is to develop a web and mobile application to help the university when it comes to establishing communication between the alumni and their alma mater. The system will aid all the colleges and departments in a university to find people for the right event, communicate, share experiences, post announcements, look for recommendations, and seek opportunities"),
                        ),
                      ),
                      Divider(),
                      Text("Creators:"),
                      Card(
                          elevation: 3,
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Image(
                                  image: AssetImage(
                                      "assets/images/avatars/avatar-2.jpg")),
                            ),
                            title: Text("Genbert Dacudao"),
                          )),
                      Card(
                          elevation: 3,
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Image(
                                  image: AssetImage(
                                      "assets/images/avatars/avatar-3.jpg")),
                            ),
                            title: Text("Romeo Dasigan"),
                          )),
                      Card(
                          elevation: 3,
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Image(
                                  image: AssetImage(
                                      "assets/images/avatars/avatar-1.jpg")),
                            ),
                            title: Text("Deric San Andres"),
                          )),
                    ],
                  ),
                ),
              ]),
            )));
  }
}
