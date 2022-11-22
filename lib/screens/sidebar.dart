import 'package:alumni_sandbox/back_end/currentUser.dart';
import 'package:flutter/material.dart';

class SideNavBar extends StatefulWidget {
  @override
  State<SideNavBar> createState() => _SideNavBarState();
}

class _SideNavBarState extends State<SideNavBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              CurrentUser.full_name,
              style: TextStyle(),
            ),
            accountEmail: Text(CurrentUser.university),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Icon(Icons.person),
              ),
            ),
          ),

          //<a href="https://www.freepik.com/free-vector/college-building-educational-institution-banner_5581911.htm#query=university&position=33&from_view=keyword">Image by vectorpocket</a> on Freepik
          /* decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/3616.jpg")),
            ),
          ),*/
          Divider(),
          ListTile(
            leading: SizedBox(
                height: 30.0,
                width: 55.0, // fixed width and height
                child: Image.asset("assets/images/gift.png")),
            title: Text('Perks & Benefits '),
            onTap: () => Navigator.pushNamed(context, "/perks"),
          ),
          ListTile(
            leading: SizedBox(
                height: 30.0,
                width: 55.0, // fixed width and height
                child: Image.asset("assets/images/online-course.png")),
            title: Text('List of Courses'),
            onTap: () => Navigator.pushNamed(context, "/courses"),
          ),
          ListTile(
            leading: SizedBox(
                height: 30.0,
                width: 55.0, // fixed width and height
                child: Image.asset("assets/images/profile.png")),
            title: Text('Your Profile'),
            onTap: () => Navigator.pushNamed(context, "/yourprofile"),
          ),
          ListTile(
            leading: SizedBox(
                height: 30.0,
                width: 55.0, // fixed width and height
                child: Image.asset("assets/images/info.png")),
            title: Text('About'),
            onTap: () => Navigator.pushNamed(context, "/about"),
          ),
          ListTile(
              title: Text('Logout'),
              leading: SizedBox(
                  height: 30.0,
                  width: 55.0, // fixed width and height
                  child: Image.asset("assets/images/shutdown.png")),
              onTap: () => {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        "/login", (Route<dynamic> route) => true)
                  }),
        ],
      ),
    );
  }
}
