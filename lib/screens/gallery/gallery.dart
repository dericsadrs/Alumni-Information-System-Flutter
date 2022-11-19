import 'dart:convert';
import 'package:alumni_sandbox/back_end/galleryList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  // ignore: non_constant_identifier_names
  late Future<List<GalleryList>> GalleryFuture = getGallery();

  @override
  void initState() {
    super.initState();
    GalleryFuture = getGallery();
  }

  static Future<List<GalleryList>> getGallery() async {
    const url = 'https://generic-ais.online/backend_app/gallery/getGallery.php';
    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body);

    return body.map<GalleryList>(GalleryList.fromJson).toList();
  }

  @override
  Widget buildview(List<GalleryList> Gallerys) => ListView.builder(
      itemCount: Gallerys.length,
      itemBuilder: (context, index) {
        int reverseIndex = Gallerys.length - 1 - index;

        final user_Gallerys = Gallerys[reverseIndex];

        return GestureDetector(
            onTap: () {},
            child: Card(
                /*elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),*/
                child: Padding(
                    padding: EdgeInsets.all(12),
                    child: ListTile(
                      title: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        SizedBox(height: 10),
                        Text( "Posted By:  ${user_Gallerys.name}",
                          style: TextStyle(
                            
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                            SizedBox(height: 10),
                        Text(user_Gallerys.description)
                        ]),
                      
                      subtitle: Image(image: NetworkImage("https://generic-ais.online/storage/${user_Gallerys.image_path}")),
                     // Container(decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(user_Gallerys.image_path)))),
                      ))));
      });

  Widget build(BuildContext context) {
    return Scaffold(
        
        appBar:
            AppBar(title: Text('Gallery'), centerTitle: true, actions: <Widget>[
          IconButton(
            icon: new Icon(Icons.edit_note),
            onPressed: () {
              Navigator.pushNamed(context, "/Galleryedit");
            },
          ),
        ]),
        body: Center(
          child: RefreshIndicator(
            onRefresh: RefreshGallery,
            child: FutureBuilder<List<GalleryList>>(
              future: GalleryFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else if (snapshot.hasData) {
                  final Gallerys = snapshot.data!;
                  return buildview(Gallerys);
                } else {
                  return const Text("No User Data");
                }
              },
            ),
          ),
        ));
  }

  Future<void> RefreshGallery() async {
    setState(() {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (a, b, c) => Gallery(),
              transitionDuration: Duration(seconds: 2)));
      Fluttertoast.showToast(
          msg: "Refreshed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    });
  }
}
