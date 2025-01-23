// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Software_Engineering extends StatefulWidget {
  const Software_Engineering({Key? key});

  @override
  State<Software_Engineering> createState() => _Software_EngineeringState();
}

class _Software_EngineeringState extends State<Software_Engineering> {
  TextEditingController inquiries = TextEditingController();

  CollectionReference adminInquirySE =
      FirebaseFirestore.instance.collection('admin_inquirySE');
  Future<void> addInquirySE() {
    return adminInquirySE
        .add({
          "Inquiries": inquiries.text,
          "id": FirebaseAuth.instance.currentUser!.uid,
          "email": FirebaseAuth.instance.currentUser!.email
        })
        .then((value) => print("inquirySE Added"))
        .catchError((error) => print("Failed to add inquiry: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Software Engineering'),
        backgroundColor: Color.fromARGB(255, 5, 66, 170),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('image/se.jpg'),
              Center(
                child: Text(
                  "Software Engineering\nBuilding and developing computer systems require precision, skill, and extreme care to avoid programming errors that can cause a lot of material and human losses.\n\nFacilitating interaction with the system, where the program is free of errors and can be developed to be in the form required by the user.\n\nEnsuring the creation and development of software systems according to tried-and-true engineering methodologies and adopted standards to be at the best performance and free of errors.",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Text("Academic Stages:"),
              Text("Subjects by Year:"),
              _buildYearListTile("First Year", [
                "1- أسسيات التكنولوجيا",
                "2- التفاضل والتكامل",
                "3- مهارات الحاسوب",
                "4- الجبر الخطي",
                "5- أسسيات البرمجة",
                "6- تصميم المنطق الرقمي",
                "7- مبادئ تراسل",
                "8-  اسسيات هندسة البرمجيات ",
                "9-  ثقافة رقمية  ",
              ]),
              _buildYearListTile("Second Year", [
                "1- الرياضيات المتقطعة",
                "2- تصميم وتنظيم الحاسوب",
                "3- كتابة تقنية",
                "4- البرمجة الموجهة للكيانات",
                "5- بنية ونمذجة  البرمجيات ",
                "6- البرمجة المرئية",
                "7- معمارية الحاسوب",
                "8-    تراكيب البيانات والخورزميات  ",
                "9- شبكات حاسوب",
              ]),
              _buildYearListTile("Third Year", [
                "1-  لغات برمجة مختارة",
                "2- قواعد بيانات",
                "3- تحليل وتصميم النظم",
                "4- البرمجة المرئية",
                "5-  ادارة مشارع البرمجيات ",
                "6- تحليل عددي",
                "7- ادرة قواعد البيانات ",
                "8-  نظم تشغيل ",
                "9- فحص البرمجيات "
              ]),
              _buildYearListTile("Fourth Year", [
                "1- تدريب ميداني",
                "2- مشروع التخرج",
                "3- مادة حرة",
                "4- تطوير البرمجيات ",
                "5- برمجمة تطبيقات الانترنت",
                "6- لغة برمجة مختاره",
                "7- احتمالات واحصاء",
              ]),
              Text("Inquiries:"),
              TextFormField(
                controller: inquiries,
                decoration: InputDecoration(
                  hintText: 'Enter your inquiry',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (inquiries.text.isNotEmpty) {
                    addInquirySE();
                    _showThankYouDialog(context, 'Enter ');
                    inquiries.clear();
                  } else {
                    _showErrorDialog(context, 'Please enter your inquiry.');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 5, 66, 170),
                ),
                child: Text('Submit Inquiry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showThankYouDialog(BuildContext context, String buttonText) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thank!'),
          content: Text('We will respond to your inquiry as soon as we can.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  ListTile _buildYearListTile(String year, List<String> subjects) {
    return ListTile(
      leading: Icon(Icons.circle),
      title: Text(year),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Subjects for $year"),
              content: Column(
                children: subjects.map((subject) => Text(subject)).toList(),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
