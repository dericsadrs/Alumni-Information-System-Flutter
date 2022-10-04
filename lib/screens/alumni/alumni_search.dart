import 'dart:convert';
import 'package:alumni_sandbox/back_end/alumniSearch.dart';
import 'package:alumni_sandbox/back_end/currentUser.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FindAlumni extends StatefulWidget {
  const FindAlumni({Key? key}) : super(key: key);

  @override
  State<FindAlumni> createState() => _FindAlumniState();
}

class _FindAlumniState extends State<FindAlumni> {
  TextEditingController name = TextEditingController();
  late Future<List<AlumniSearch>> findAlumniFuture = FindAlumni();

  @override
  void initState() {
    super.initState();
  }

  // ignore: non_constant_identifier_names
  Future<List<AlumniSearch>> FindAlumni() async {
    const url = 'https://192.168.0.110/backend_app/alumni/searchAlumni.php';
    final send = await http.post(Uri.parse(url), body: {"name": name.text});
    final fetchAlumni = await http.get(
      Uri.parse(url),
    );
    //final response = await http.post(Uri.parse(url), body: {"name": name.text});
    final body = jsonDecode(fetchAlumni.body);
    print(fetchAlumni.body);
    return body.map<AlumniSearch>(AlumniSearch.fromJson).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // The search area here
          title: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: TextField(
                  controller: name,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.find_in_page),
                        onPressed: () {
                          FindAlumni();
                        },
                      ),
                      hintText: 'Search...',
                      border: InputBorder.none),
                ),
              ))),
      body: Center(
        child: FutureBuilder<List<AlumniSearch>>(
          future: findAlumniFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (snapshot.hasData) {
              final finds = snapshot.data!;
              return buildview(finds);
            } else {
              return const Text("No User Data");
            }
          },
        ),
      ),
    );
  }

  Widget buildview(List<AlumniSearch> finds) => ListView.builder(
      itemCount: finds.length,
      itemBuilder: (context, index) {
        final userfound = finds[index];

        return GestureDetector(
            onTap: () {},
            child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                    padding: EdgeInsets.all(12),
                    child: ListTile(
                      leading: CircleAvatar(),
                      trailing: Icon(Icons.keyboard_arrow_right_rounded),
                      title: Text(
                        userfound.full_name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        userfound.course_name,
                      ),
                      dense: true,
                    ))));
      });
}
