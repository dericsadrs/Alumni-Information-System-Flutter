// ignore_for_file: prefer_const_constructors
import 'dart:convert';

import 'package:alumni_sandbox/back_end/currentUser.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

// Instance of the Stateful Widget
class _LoginState extends State<Login> {
  TextEditingController email_address = new TextEditingController();
  TextEditingController password = new TextEditingController();

  Future _login() async {
    final response = await http.post(
      Uri.parse("https://192.168.0.110/backend_app/user/userLogin.php"),
      body: {
        "email_address": email_address.text,
        "password": password.text,
      },
    );
    var data = json.decode(response.body);

    if (data['loginStatus'] == true) {
      CurrentUser().getData(
        data['id'],
        data['title'],
        data['full_name'],
        data['university'],
        data['course_name'],
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
      );
      CurrentUser().displayData();

      Fluttertoast.showToast(
          msg: "Welcome",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);

      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, "/menu");
    } else if (data['loginStatus'] == false) {
      Fluttertoast.showToast(
          msg: "Wrong Credentials",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset("assets/json/28893-book-loading.json",
                      width: 250),
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
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(128, 255, 255, 255),
                          border: Border.all(
                              color: Color.fromARGB(255, 255, 255, 255)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: TextField(
                              controller: email_address,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email),
                                border: InputBorder.none,
                                hintText: "Enter your Email",
                              ),
                            ))),
                  ),
                  SizedBox(height: 20),

                  // Password Field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(0, 161, 160, 160),
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: TextField(
                              controller: password,
                              obscureText: true,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.password_sharp),
                                border: InputBorder.none,
                                hintText: "Enter Password",
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
                        "Forgot Password?",
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 138, 251),
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ))
                ],
              )),
        ));
  }
}
