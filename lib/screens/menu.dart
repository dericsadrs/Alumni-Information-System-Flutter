import 'package:alumni_sandbox/screens/alumni/alumni.dart';
import 'package:alumni_sandbox/screens/sidebar.dart';
import 'package:alumni_sandbox/main.dart';
import 'package:flutter/material.dart';
import 'package:alumni_sandbox/screens/colors.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

// Instance of the Stateful Widget
class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideNavBar(),
      appBar: AppBar(
        title: const Text('Menu',style: TextStyle( fontSize: 20)),
        centerTitle: true,
        backgroundColor: Colors.blue,
        /*shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50),
                bottomLeft: Radius.circular(50))),
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(90),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
            )),*/
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(74),
        crossAxisSpacing: 50,
        mainAxisSpacing: 40,
        crossAxisCount: 2,
        children: <Widget>[
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/feed");
              }, // route here
              child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          scale: 1.6,
                          image: AssetImage("assets/images/feed.png")),
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 255, 255, 255),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(7.0, 8.0))
                      ]),
                  child: Align(
                      alignment: Alignment(0.02, 0.96), child: Text("FEED",style: TextStyle( fontSize: 20),)))),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/job");
            }, // route here

            child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        scale: 1.6, image: AssetImage("assets/images/job.png")),
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 255, 255, 255),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(7.0, 8.0))
                    ]),
                child: Align(
                    alignment: Alignment(0.02, 0.93), child: Text("JOB",style: TextStyle( fontSize: 20)))),
          ),
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/gallery");
              },
              child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          scale: 1.6,
                          image: AssetImage("assets/images/gallery.png")),
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 255, 255, 255),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(7.0, 8.0))
                      ]),
                  child: Align(
                      alignment: Alignment(0.02, 0.93),
                      child: Text("GALLERY",style: TextStyle( fontSize: 20))))),
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/alumni");
              },
              child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          scale: 1.6,
                          image: AssetImage("assets/images/list_alumni.png")),
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 255, 255, 255),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(7.0, 8.0))
                      ]),
                  child: Align(
                      alignment: Alignment(0.02, 0.93),
                      child: Text("ALUMNI",style: TextStyle( fontSize: 20))))),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/forum");
            },
            child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        scale: 1.6,
                        image: AssetImage("assets/images/forum.png")),
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 255, 255, 255),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(7.0, 8.0))
                    ]),
                child: Align(
                    alignment: Alignment(0.2, 0.93), child: Text("FORUM",style: TextStyle( fontSize: 20)))),
          )
        ],
      ),
    );
  }
}
