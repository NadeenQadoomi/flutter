// ignore_for_file: prefer_const_constructors, camel_case_types, file_names, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Network_security_and_confidentiality extends StatefulWidget {
  const Network_security_and_confidentiality({Key? key});

  @override
  State<Network_security_and_confidentiality> createState() =>
      _Network_security_and_confidentialityState();
}

class _Network_security_and_confidentialityState
    extends State<Network_security_and_confidentiality> {
  TextEditingController Inquiries = TextEditingController();

  CollectionReference admin_inquiryNSC =
      FirebaseFirestore.instance.collection('admin_inquiryNSC');
  Future<void> addInquiryNSCo() {
    return admin_inquiryNSC
        .add({
          "Inquiries": Inquiries.text,
          "id": FirebaseAuth.instance.currentUser!.uid,
          "email": FirebaseAuth.instance.currentUser!.email
        })
        .then((value) => print("admin_inquiryNSC"))
        .catchError((error) => print("Failed to add inquiry: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Network Security'),
        backgroundColor: Color.fromARGB(255, 5, 66, 170),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('image/ss.jpg'),
              Text(
                "Information Security\nof networks and information is a branch of information technology and is the process of protecting systems, networks and programs against digital attacks. These cyber attacks usually aim to access or change sensitive information and also fall within the scope of attack with either protection or sabotage intent.",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text("Subjects by Year:"),
              _buildYearListTile("First Year", [
                "1- أسسيات التكنولوجيا",
                "2- التفاضل والتكامل",
                "3- مهارات الحاسوب",
                "4- الجبر الخطي",
                "5-  شبكات حاسوب ",
                "6- تصميم المنطق الرقمي",
                "7- مبادئ تراسل والشبكات  ",
                "8-كتابة تقنية"
                    "9- البرمجة المرئية "
                    "10- انجليزي "
                    "11- دسكريت"
              ]),
              _buildYearListTile("Second Year", [
                "1-  امن معلومات ",
                "2-   تحليل عددي ",
                "3- البرمجة المرئية",
                "4- البرمجة الموجهة للكيانات",
                "5-  شبكات الحاسوب اللاسلكية ",
                "6-  لغات برمجة مختاره ",
                "7-  تراكيب البيانات والخورزميات  ",
                "8-  نظم تشغيل لينكس ",
              ]),
              _buildYearListTile("Third Year", [
                "1- نظم تشغيل",
                "2- قواعد بيانات",
                "3-   مراقبة الشبكات  ",
                "4-  تحليل وتصميم النظم ",
                "5- نظرية التشفير  ",
                "6-  بروتوكلات ",
                "7- خوارزميات",
                "8- امن شبكات",
                "9- برمجة تطبيقات الانترنت  ",
              ]),
              _buildYearListTile("Fourth Year", [
                "1- تدريب ميداني",
                "2- مشروع التخرج",
                "3- مادة حرة",
                "4- اختراق اخلاقي",
                "5-   تحليل مخاطر ",
                "6-    جرائم الالكترونيات  ",
                "7- احتمالات واحصاء",
              ]),
              Text("inquiries:"),
              TextFormField(
                controller: Inquiries,
                decoration: InputDecoration(
                  hintText: 'Send Inquiry',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (Inquiries.text.isNotEmpty) {
                    addInquiryNSCo();
                    _showThankYouDialog(context, 'Enter ');

                    // Clear the text field after submitting the inquiry
                    Inquiries.clear();
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
