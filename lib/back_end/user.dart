import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<User> fetchUser() async {
  final response = await http
      .get(Uri.parse('https://192.168.0.110/backend_app/getuser.php'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return User.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load User');
  }
}

class User {
  final int alumni_id;
  final String full_name;
  final String email_address;
  final String university;
  final int address;
  final String course;
  final String year_graduated;
  final String civil_status;
  final String job;
  final String title;

  const User({
    required this.alumni_id,
    required this.full_name,
    required this.email_address,
    required this.university,
    required this.address,
    required this.course,
    required this.year_graduated,
    required this.civil_status,
    required this.job,
    required this.title,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      alumni_id: json['alumni_id'],
      full_name: json['full_name'],
      email_address: json['email_address'],
      university: json['university'],
      address: json['address'],
      course: json['course'],
      year_graduated: json['year_graduated'],
      civil_status: json['civil_status'],
      job: json['job'],
      title: json['title'],
    );
  }
}
