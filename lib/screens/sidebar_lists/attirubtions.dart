// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Attributions extends StatefulWidget {
  @override
  State<Attributions> createState() => _AttributionsState();
}

class _AttributionsState extends State<Attributions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Attributions'),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Divider(),
            ListTile(
              leading: SizedBox(
                  height: 30.0,
                  width: 55.0, // fixed width and height
                  child: Image.asset("assets/images/icons8.png")),
              title: Text(
                'icons 8',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              onTap: () async {
                const redirectUrl = "https://icons8.com/license";
                // ignore: deprecated_member_use
                if (await launch(redirectUrl)) {
                  // ignore: deprecated_member_use
                  await launch(redirectUrl,
                      forceWebView: true, enableJavaScript: true);
                }
              },
              subtitle: Text(
                  "Download design elements for free: icons, photos, vector illustrations, and music for your videos. All the assets made by designers → consistent quality."),
            ),
            ListTile(
                leading: SizedBox(
                    height: 30.0,
                    width: 55.0, // fixed width and height
                    child: Image.asset("assets/images/lottie.png")),
                title: Text('Lottie'),
                onTap: () async {
                  const redirectUrl = "https://lottiefiles.com/page/license";
                  // ignore: deprecated_member_use
                  if (await launch(redirectUrl)) {
                    // ignore: deprecated_member_use
                    await launch(redirectUrl,
                        forceWebView: true, enableJavaScript: true);
                  }
                },
                subtitle: Text(
                    "LottieFiles takes away the complexity from Motion Design. It lets you Create, Edit, Test, Collaborate and Ship a Lottie in the easiest way possible.")),
          ],
        ));
  }
}
