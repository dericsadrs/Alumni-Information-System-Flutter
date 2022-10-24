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
  Future fetchImages() async {
    // >> To get paths you need these 2 lines
    final manifestData = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> convertedManifest = json.decode(manifestData);
    // >> To get paths you need these 2 lines

    final imagePaths = convertedManifest.keys
        .where((String key) => key.contains('images/gallery/'))
        .where((String key) => key.contains('.jpg'))
        .toList();

    setState(() {
      image_paths = imagePaths;
      print(image_paths);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
