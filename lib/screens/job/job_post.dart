import 'package:flutter/material.dart';

class JobPost extends StatelessWidget {
  const JobPost({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Post a Job Opening'),
          centerTitle: true,
        ),
        body: Column(children: [
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
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
                      child: TextField(
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 10,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: ' Job Title Here')),
                    ),
                  ],
                )),
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
                        height: 100,
                      ), // Container
                    ),
                    Expanded(
                      child: TextField(
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 10,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: ' Job Information Here')),
                    ),
                  ],
                )),
          ),
          SizedBox(
            height: 25,
          ),
          GestureDetector(
              onTap: () {},
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70.0),
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
        ]));
  }
}
