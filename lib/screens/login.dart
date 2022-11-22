// ignore_for_file: prefer_const_constructors
import 'dart:convert';

import 'package:alumni_sandbox/back_end/currentUser.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

// Instance of the Stateful Widget
class _LoginState extends State<Login> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  Future _login() async {
    final response = await http.post(
      Uri.parse("https://generic-ais.online/backend_app/user/userLogin.php"),
      body: {
        "email": email.text,
        "password": password.text,
      },
    );
    var data = json.decode(response.body);
    print(data);

    if (data['loginStatus'] == true) {
      CurrentUser().getData(
        data['id'],
        data['title'],
        data['full_name'],
        data['university'],
        data['course'],
        data['email_address'],
        data['gender'],
        data['address'],
        data['contact_number'],
        data['civil_status'],
        data['job_business'],
        data['business_address'],
        data['high_school'],
        data['high_school_yg'],
        data['senior_highschool'],
        data['senior_highschool_yg'],
        data['college_batch'],
        data['birthday'],
        data['nickname'],
        data['image_path'],
      );
      CurrentUser().displayData();

      Fluttertoast.showToast(
          msg: "Welcome",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);

      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, "/menu");
    } else if (data['loginStatus'] == false) {
      if (data['message'] == "!pw") {
        Fluttertoast.showToast(
            msg: "Wrong Password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
      } else if (data['message'] == "!user") {
        Fluttertoast.showToast(
            msg: "User Not Found",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
      } else if (data['message'] == "error_db") {
        Fluttertoast.showToast(
            msg: "Error Connecting to the Database",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
      } else if (data['message'] == "pending") {
        Fluttertoast.showToast(
            msg: "Pending for Approval",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
      } else if (data['message'] == "fatal_error") {
        Fluttertoast.showToast(
            msg: "Fatal Error",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
      } else {
        Fluttertoast.showToast(
            msg: "Eror Logging In",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Error!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: SafeArea(
            child: SingleChildScrollView(
          reverse: true,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Lottie.asset("assets/json/28893-book-loading.json", width: 250),
            SizedBox(
              height: 25,
            ),
            Text(
              "WELCOME",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "Sign in to your account",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            SizedBox(height: 30),

            //Email Text Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(62, 128, 126, 126),
                    border:
                        Border.all(color: Color.fromARGB(255, 255, 255, 255)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: email,
                        decoration: InputDecoration(
                          prefixIcon: SizedBox(
                              child: Image.asset("assets/images/gmail.png")),
                          border: InputBorder.none,
                          hintText: "Enter your Email",
                        ),
                      ))),
            ),
            SizedBox(height: 20),

            // Password Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(62, 128, 126, 126),
                    border:
                        Border.all(color: Color.fromARGB(255, 255, 255, 255)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: password,
                        decoration: InputDecoration(
                          prefixIcon: SizedBox(
                              child: Image.asset("assets/images/password.png")),
                          border: InputBorder.none,
                          hintText: "Enter your Email",
                        ),
                      ))),
            ),
            SizedBox(height: 20),

            // Sign in Button
            GestureDetector(
                onTap: () {
                  _login();
                  //Navigator.pushNamed(context, "/menu");
                },
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 70.0),
                    child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 0, 119, 255),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                            child: Text("Sign In",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                )))))),
            SizedBox(height: 10),

            // Forgot Password
            GestureDetector(
                /* onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DashBoard()));*/

                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Register",
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 138, 251),
                      fontWeight: FontWeight.bold),
                )
              ],
            )),
            SizedBox(height: 5
            
            
            
            0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    const redirectUrl = "https://icons8.com/license";
                    // ignore: deprecated_member_use
                    if (await launch(redirectUrl)) {
                      // ignore: deprecated_member_use
                      await launch(redirectUrl,
                          forceWebView: true, enableJavaScript: true);
                    }
                  },
                  child: Text(
                    "Icons by ICONS8",
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 138, 251),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                GestureDetector(
                  onTap: () async {
                    const redirectUrl = "https://lottiefiles.com/page/license";
                    // ignore: deprecated_member_use
                    if (await launch(redirectUrl)) {
                      // ignore: deprecated_member_use
                      await launch(redirectUrl,
                          forceWebView: true, enableJavaScript: true);
                    }
                  },
                  child: Text(
                    "Animations by Lottie",
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 138, 251),
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ]),
        )));
  }
}
