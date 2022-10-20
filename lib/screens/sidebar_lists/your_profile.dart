import 'package:alumni_sandbox/back_end/currentUser.dart';
import 'package:flutter/material.dart';

class YourProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alumni Profile'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/images/profile.png"))),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Center(
                  child: Column(children: [
                Text(
                  CurrentUser.full_name,
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  CurrentUser.email_address,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ])),
              SizedBox(
                height: 25,
              ),
              ListTile(
                leading: Icon(Icons.account_balance_sharp),
                title: Text(CurrentUser.university),
              ),
              ListTile(
                leading: Icon(Icons.school),
                title: Text(CurrentUser.course_name),
                subtitle: Text("Year Graduated: " + CurrentUser.college_batch),
              ),
              ListTile(
                leading: Icon(Icons.corporate_fare),
                title: Text(CurrentUser.job_business),
                subtitle: Text(CurrentUser.business_address),
              ),
              ListTile(
                leading: Icon(Icons.pin_drop),
                title: Text(CurrentUser.civil_status),
                subtitle: Text(CurrentUser.gender),
              ),
              ListTile(
                leading: Icon(Icons.contact_mail),
                title: Text(
                  CurrentUser.address,
                ),
                subtitle: Text(CurrentUser.contact_number),
              ),
              Divider(
                height: 40,
              ),
              Text("Education: "),
              ListTile(
                leading: Icon(Icons.school),
                title: Text("Senior High: " + CurrentUser.senior_highschool),
                subtitle:
                    Text("Year Graduated: " + CurrentUser.senior_highschool_yg),
              ),
              ListTile(
                leading: Icon(Icons.school),
                title: Text("Junior High: " + CurrentUser.high_school),
                subtitle: Text("Year Graduated: " + CurrentUser.high_school_yg),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
