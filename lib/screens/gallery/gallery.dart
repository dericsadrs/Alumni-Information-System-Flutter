import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  late List image_paths = [];
  Future _initImages() async {
    // >> To get paths you need these 2 lines
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines

    final imagePaths = manifestMap.keys
        .where((String key) => key.contains('images/gallery/'))
        .where((String key) => key.contains('.jpg'))
        .toList();

    setState(() {
      image_paths = imagePaths;
      print(image_paths);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _initImages();
          },
          label: const Text('Post a Question'),
          icon: const Icon(Icons.add_comment),
        ),
        appBar: AppBar(
          title: Text('Gallery'),
        ),
        body: buildview());
  }

  Widget buildview() => GridView.builder(
      itemCount: image_paths.length,
      itemBuilder: (context, index) {
        final picture = image_paths[index];

        return Container(
            padding: EdgeInsets.all(5),
            child: FittedBox(
              child: Image.asset(picture),
              fit: BoxFit.fill,
            ));
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ));
}
