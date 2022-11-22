import 'dart:convert';
import 'dart:io';
import 'package:alumni_sandbox/back_end/currentUser.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({Key? key}) : super(key: key);

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? imageFile;
  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 800,
      maxHeight: 800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  final picker = ImagePicker();
  TextEditingController feedtitle = new TextEditingController();
  TextEditingController content = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Gallery'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              SizedBox(
                width: 38,
              ),
              Text("Posting as:  "),
              Text(CurrentUser.full_name),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ), // BoxDecoration
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        height: 50,
                      ), // Container
                    ),
                    Expanded(
                      child: TextFormField(
                          controller: content,
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: null,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Image Description')),
                    ),
                  ],
                )),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              child: Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlinedButton(
                  onPressed: () {
                    _getFromGallery();
                  },
                  child: Text("PICK FROM GALLERY"),
                ),
                Container(
                  height: 10.0,
                ),
                OutlinedButton(
                  onPressed: () {
                    _getFromCamera();
                  },
                  child: Text("PICK FROM CAMERA"),
                )
              ],
            ),
          )),
          Container(
              child: imageFile == null
                  ? Text("Select an Image")
                  : Image.file(
                      imageFile!,
                      width: 450.0,
                      height: 450.0,
                    )),
          SizedBox(
            height: 25,
          ),
          GestureDetector(
              onTap: () {},
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100.0),
                  child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 0, 119, 255),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                          child: Text("Post",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              )))))),
        ])));
  }
}
