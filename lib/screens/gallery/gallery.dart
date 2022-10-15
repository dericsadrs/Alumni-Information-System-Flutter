import 'dart:convert';

import 'package:alumni_sandbox/back_end/galleryList.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  late Future<List<GalleryList>> galleryFuture = getGallery();

  @override
  void initState() {
    super.initState();
    galleryFuture = getGallery();
  }

  static Future<List<GalleryList>> getGallery() async {
    const url = 'https://192.168.0.110/backend_app/gallery/getGallery.php';
    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body);
    return body.map<GalleryList>(GalleryList.fromJson).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<List<GalleryList>>(
          future: galleryFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (snapshot.hasData) {
              final pictures = snapshot.data!;

              return buildview(pictures);
            } else {
              return const Text("No User Data");
            }
          },
        ),
      ),
    );
  }

  Widget buildview(List<GalleryList> pictures) => GridView.builder(
      itemCount: pictures.length,
      itemBuilder: (context, index) {
        final picture = pictures[index];

        return Container(
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(picture.image_path)),
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(255, 255, 255, 255),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(7.0, 8.0))
              ]),
        );
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ));
}
