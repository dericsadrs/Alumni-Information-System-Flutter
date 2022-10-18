import 'dart:io';

import 'package:alumni_sandbox/screens/alumni/alumni_search.dart';
import 'package:alumni_sandbox/screens/feed/feed_editing.dart';
import 'package:alumni_sandbox/screens/feed/feed_post.dart';
import 'package:alumni_sandbox/screens/forum/forum.dart';
import 'package:alumni_sandbox/screens/alumni/alumni.dart';
import 'package:alumni_sandbox/screens/feed/feed.dart';
import 'package:alumni_sandbox/screens/forum/post_question.dart';
import 'package:alumni_sandbox/screens/gallery/gallery.dart';
import 'package:alumni_sandbox/screens/job/jobuser_posts.dart';
import 'package:alumni_sandbox/screens/login.dart';
import 'package:alumni_sandbox/screens/menu.dart';
import 'package:alumni_sandbox/screens/onboarding.dart';
import 'package:alumni_sandbox/screens/job/job.dart';
import 'package:alumni_sandbox/screens/sidebar_lists/about.dart';
import 'package:alumni_sandbox/screens/sidebar_lists/courses.dart';
import 'package:alumni_sandbox/screens/sidebar_lists/perks.dart';
import 'package:alumni_sandbox/screens/sidebar_lists/your_profile.dart';

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

        // Basic Functionalities

        "/login": (context) => Login(),
        "/menu": (context) => const Menu(),
        "/alumni": (context) => Alumni(),
        "/gallery": (context) => Gallery(),
        "/findalumni": (context) => FindAlumni(),
        "/feed": (context) => Feed(),
        "/job": (context) => Job(),
        "/feedpost": (context) => FeedPost(),
        "/jobpost": (context) => JobPost(),
        "/courses": (context) => Courses(),
        "/perks": (context) => Perks(),
        "/forum": (context) => Forum(),

        //Sidebar
        "/yourprofile": (context) => YourProfile(),

        "/feededit": (context) => FeedEdit(),
        "/postquestion": (context) => Question(),
        "/jobedit": (context) => EditJob(),
        "/about": (context) => About(),
      },
    ),
  );
}
