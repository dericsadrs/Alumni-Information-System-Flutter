import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../back_end/perksList.dart';

class Perks extends StatefulWidget {
  const Perks({Key? key}) : super(key: key);

  @override
  State<Perks> createState() => _PerksState();
}

class _PerksState extends State<Perks> {
  late Future<List<PerksList>> PerksFuture = getPerks();

  @override
  void initState() {
    super.initState();
    PerksFuture = getPerks();
  }

  static Future<List<PerksList>> getPerks() async {
    const url = 'https://192.168.0.110/backend_app/perks/getPerks.php';
    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body);
    return body.map<PerksList>(PerksList.fromJson).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perks'),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<List<PerksList>>(
          future: PerksFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (snapshot.hasData) {
              final Perkss = snapshot.data!;
              return buildview(Perkss);
            } else {
              return const Text("No User Data");
            }
          },
        ),
      ),
    );
  }

  Widget buildview(List<PerksList> benefits) => ListView.builder(
      itemCount: benefits.length,
      itemBuilder: (context, index) {
        final user = benefits[index];

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
                      title: Text(
                        user.content,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      subtitle: Text(
                        user.date_published,
                      ),
                      dense: true,
                    ))));
      });
}
