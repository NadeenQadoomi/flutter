// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Computer_Science extends StatefulWidget {
  const Computer_Science({Key? key}) : super(key: key);

  @override
  State<Computer_Science> createState() => _Computer_ScienceState();
}

class _Computer_ScienceState extends State<Computer_Science> {
  TextEditingController inquiries = TextEditingController();

  CollectionReference adminInquiry =
      FirebaseFirestore.instance.collection('admin_inquiry');

  Future<void> addInquiry() {
    return adminInquiry
        .add({
          "Inquiries": inquiries.text,
          "id": FirebaseAuth.instance.currentUser!.uid,
          "email": FirebaseAuth.instance.currentUser!.email,
        })
        .then((value) => print("Inquiry Added"))
        .catchError((error) => print("Failed to add inquiry: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Computer Science'),
        backgroundColor: Color.fromARGB(255, 5, 66, 170),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('image/cs.jpg'),
              Text(
                "CS 💻\nIt is the most comprehensive specialization among all IT specializations and one of the specializations that relies on logic and mathematics. Students take courses in areas such as networks, databases, artificial intelligence, information security, and web development... and, of course, many other courses in the world of technology.",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text("Subjects by Year:"),
              _buildYearListTile("First Year", [
                "1- أسسيات التكنولوجيا",
                "2- التفاضل والتكامل",
                "3- مهارات الحاسوب",
                "4- الجبر الخطي",
                "5- أسسيات البرمجة",
                "6- تصميم المنطق الرقمي",
                "7- مبادئ تراسل",
              ]),
              _buildYearListTile("Second Year", [
                "1- الرياضيات المتقطعة",
                "2- تصميم وتنظيم الحاسوب",
                "3- كتابة تقنية",
                "4- البرمجة الموجهة للكيانات",
                "5- أسسيات الهندسة",
                "6- البرمجة المرئية",
                "7- معمارية الحاسوب",
                "8- تراكيب البيانات",
                "9- شبكات حاسوب",
              ]),
              _buildYearListTile("Third Year", [
                "1- نظم لينكس",
                "2- قواعد بيانات",
                "3- نظرية الحاسوب",
                "4- البرمجة المرئية",
                "5- امن معلومات",
                "6- تحليل عددي",
                "7- خوارزميات",
                "8- امن شبكات",
                "9- تحليل وتصميم النظم",
              ]),
              _buildYearListTile("Fourth Year", [
                "1- تدريب ميداني",
                "2- مشروع التخرج",
                "3- مادة حرة",
                "4- لينكس",
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
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (inquiries.text.isNotEmpty) {
                    addInquiry();
                    _showThankYouDialog(context, 'enter ');

                    setState(() {
                      inquiries.text = '';
                    });
                  } else {
                    _showErrorDialog(context, 'Please enter your inquiry.');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 5, 66, 170),
                ),
                child: Text('Send Inquiry'),
              ),
            ],
          ),
        ),
      ),
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

  void _showThankYouDialog(BuildContext context, String buttonText) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thanks!'),
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

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
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
}
