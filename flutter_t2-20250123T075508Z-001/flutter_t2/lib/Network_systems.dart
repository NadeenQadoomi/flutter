// ignore_for_file: prefer_const_constructors, camel_case_types, file_names, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Network_systems extends StatefulWidget {
  const Network_systems({Key? key});

  @override
  State<Network_systems> createState() => _Network_systemsState();
}

class _Network_systemsState extends State<Network_systems> {
  TextEditingController inquiries = TextEditingController();

  CollectionReference adminInquiryNS =
      FirebaseFirestore.instance.collection('admin_inquiryNS');
  Future<void> addInquiryNS() {
    return adminInquiryNS
        .add({
          "Inquiries": inquiries.text,
          "id": FirebaseAuth.instance.currentUser!.uid,
          "email": FirebaseAuth.instance.currentUser!.email
        })
        .then((value) => print("inquiryNS"))
        .catchError((error) => print("Failed to add inquiry: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Network Systems'),
        backgroundColor: Color.fromARGB(255, 5, 66, 170),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('image/ns.jpg'),
              Text(
                "Computer Network Systems\nIt is a comprehensive specialization among all IT specializations. It involves designing and building software that enables users to interact with information systems easily. In the beginning, all subjects are common with college students, and then there is some variation in some subjects. For example, a student in network systems takes subjects with more information about networks and their security.\n\nIn this specialization, a student learns how to write programs in programming languages, manage networks, and important protocols used in the network.\n\nA student takes subjects related to building and managing networks, as well as subjects related to programming. Among the important languages learned are Java and Python.",
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
                "7- مبادئ تراسل والشبكات  ",
                "9- البرمجة المرئية "
              ]),
              _buildYearListTile("Second Year", [
                "1- الرياضيات المتقطعة",
                "2- تصميم وتنظيم الحاسوب",
                "3- كتابة تقنية",
                "4- البرمجة الموجهة للكيانات",
                "5-  شبكات الحاسوب اللاسلكية ",
                "6-  لغات برمجة مختاره ",
                "7- تراكيب البيانات",
                "8- شبكات حاسوب",
              ]),
              _buildYearListTile("Third Year", [
                "1- نظم تشغيل",
                "2- قواعد بيانات",
                "3-  بروتوكولات الشبكات ",
                "4- البرمجة المرئية",
                "5- امن معلومات",
                "6- تحليل عددي",
                "7- خوارزميات",
                "8- امن شبكات",
                "9- برمجة شبكات ",
              ]),
              _buildYearListTile("Fourth Year", [
                "1- تدريب ميداني",
                "2- مشروع التخرج",
                "3- مادة حرة",
                "4- لينكس",
                "5- برمجمة تطبيقات الانترنت",
                "6-   أدارة الشبكات ",
                "7- احتمالات واحصاء",
              ]),
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
                    addInquiryNS();
                    _showThankYouDialog(context, 'Enter ');

                    // Clear the text field after submitting the inquiry
                    inquiries.clear();
                  } else {
                    // Show an error message if the text field is empty
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
