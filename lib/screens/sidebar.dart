import 'package:alumni_sandbox/back_end/currentUser.dart';
import 'package:flutter/material.dart';

class SideNavBar extends StatefulWidget {
  @override
  State<SideNavBar> createState() => _SideNavBarState();
}

class _SideNavBarState extends State<SideNavBar> {
  @override
  bool tappedYes = false;
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              CurrentUser.full_name,
              style: TextStyle(fontSize: 18),
            ),
            accountEmail: Text(
              CurrentUser.university,
              style: TextStyle(fontSize: 15),
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image(
                    image: NetworkImage(
                        "https://generic-ais.online/storage/${CurrentUser.image_path}")),
              ),
            ),
          ),
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
            //https://icons8.com/license
            leading: SizedBox(
                height: 30.0,
                width: 55.0, // fixed width and height
                child: Image.asset("assets/images/gift.png")),
            title: Text('Attiributions'),
            onTap: () => Navigator.pushNamed(context, "/perks"),
          ),
          ListTile(
              title: Text('Logout'),
              leading: SizedBox(
                  height: 30.0,
                  width: 55.0, // fixed width and height
                  child: Image.asset("assets/images/shutdown.png")),
              onTap: () async {
                final action =
                    await DialogLogOut.yesAbortDialog(context, "Logout?");
                if (action == DialogAction.yes) {
                  setState(() => tappedYes = true);
                  Navigator.of(context).popAndPushNamed("/login");
                } else {
                  setState(() => tappedYes = false);
                }
              }),
        ],
      ),
    );
  }
}

enum DialogAction { yes, abort }

class DialogLogOut {
  static Future<DialogAction> yesAbortDialog(
    BuildContext context,
    String title,
  ) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(title),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(DialogAction.abort),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(DialogAction.yes),
              child: const Text(
                'Yes',
              ),
            ),
          ],
        );
      },
    );
    return (action != null) ? action : DialogAction.abort;
  }
}
