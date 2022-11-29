import 'dart:convert';

import 'package:alumni_sandbox/back_end/currentUser.dart';
import 'package:alumni_sandbox/back_end/galleryList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class GalleryEdit extends StatefulWidget {
  const GalleryEdit({Key? key}) : super(key: key);

  @override
  State<GalleryEdit> createState() => _GalleryEditState();
}

class _GalleryEditState extends State<GalleryEdit> {
  // ignore: non_constant_identifier_names
  bool tappedYes = false;

  late Future<List<UserGallery>> GalleryEditFuture = getGalleryEdit();

  @override
  void initState() {
    super.initState();
    GalleryEditFuture = getGalleryEdit();
  }

  static Future<List<UserGallery>> getGalleryEdit() async {
    const url =
        'https://generic-ais.online/backend_app/gallery/fetchUserGallery.php';
    final response =
        await http.post(Uri.parse(url), body: {"user_id": CurrentUser.id});
    final body = jsonDecode(response.body);
    return body.map<UserGallery>(UserGallery.fromJson).toList();
  }

  Future deletePost(String passID) async {
    const url =
        'https://generic-ais.online/backend_app/gallery/deleteUserGallery.php';
    final response = await http.post(Uri.parse(url), body: {"id": passID});
    final body = jsonDecode(response.body);
    Fluttertoast.showToast(
        msg: "Post Deleted",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM);
    RefreshGalleryEdit();
  }

  @override
  Widget buildview(List<UserGallery> GalleryEdits) => ListView.builder(
      itemCount: GalleryEdits.length,
      itemBuilder: (context, index) {
        int reverseIndex = GalleryEdits.length - 1 - index;

        final user_GalleryEdits = GalleryEdits[reverseIndex];

        return GestureDetector(
            onTap: () {},
            child: Card(
                child: Padding(
                    padding: EdgeInsets.all(12),
                    child: ListTile(
                      title: Column(
                        children: [
                          Image(
                              image: NetworkImage(
                                  "https://generic-ais.online/storage/${user_GalleryEdits.image_path}")),
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                user_GalleryEdits.description,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 13),
                              ))
                        ],
                      ),
                      subtitle: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () async {
                                final action =
                                    await GalleryUserDialog.yesAbortDialog(
                                        context,
                                        "Delete this post?",
                                        user_GalleryEdits.description);
                                if (action == DialogAction.yes) {
                                  setState(() => tappedYes = true);
                                  deletePost(user_GalleryEdits.id);
                                } else {
                                  setState(() => tappedYes = false);
                                }
                              },
                              child: Text("Delete"),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ]),
                    ))));
      });

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Gallery Edit'),
            centerTitle: true,
            actions: <Widget>[]),
        body: Center(
          child: RefreshIndicator(
            onRefresh: RefreshGalleryEdit,
            child: FutureBuilder<List<UserGallery>>(
              future: GalleryEditFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else if (snapshot.hasData) {
                  final GalleryEdits = snapshot.data!;
                  return buildview(GalleryEdits);
                } else {
                  return const Text("No User Data");
                }
              },
            ),
          ),
        ));
  }

  Future<void> RefreshGalleryEdit() async {
    setState(() {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (a, b, c) => GalleryEdit(),
              transitionDuration: Duration(seconds: 2)));
      Fluttertoast.showToast(
          msg: "Refreshed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    });
  }
}

enum DialogAction { yes, abort }

class GalleryUserDialog {
  static Future<DialogAction> yesAbortDialog(
    BuildContext context,
    String title,
    String body,
  ) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(title),
          content: Text(body),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(DialogAction.abort),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(DialogAction.yes),
              child: const Text(
                'Yes',
              ),
            ),
          ],
        );
      },
    );
    return (action != null) ? action : DialogAction.abort;
  }
}
