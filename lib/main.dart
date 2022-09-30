import 'dart:io';

import 'package:alumni_sandbox/screens/forum/forum.dart';
import 'package:alumni_sandbox/screens/alumni/alumni.dart';

import 'package:alumni_sandbox/screens/feed/feed.dart';
import 'package:alumni_sandbox/screens/feed/post.dart';

import 'package:alumni_sandbox/screens/menu.dart';
import 'package:alumni_sandbox/screens/onboarding.dart';
import 'package:alumni_sandbox/screens/job/job.dart';
import 'package:flutter/material.dart';

import 'screens/job/job_post.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();

  runApp(
    MaterialApp(
      title: 'Alumni Information System',
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.

      initialRoute: "/",
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        "/": (context) => const Onboarding(),
        "/menu": (context) => const Menu(),
        "/alumni": (context) => Alumni(),
        //"/alumni_profile": (context) => AlumniProfile(),
        "/feed": (context) => Feed(),
        "/job": (context) => Job(),
        "/post": (context) => Post(),
        "/jobpost": (context) => JobPost(),
        "/forum": (context) => Forum(),
      },
    ),
  );
}
