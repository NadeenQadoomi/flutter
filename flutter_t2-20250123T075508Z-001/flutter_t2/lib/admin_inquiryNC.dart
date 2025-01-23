// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class admin_inquiryNC extends StatefulWidget {
  const admin_inquiryNC({super.key});

  @override
  State<admin_inquiryNC> createState() => _admin_inquiryNCState();
}

class _admin_inquiryNCState extends State<admin_inquiryNC> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 5, 66, 170),
        title: Text('N_C student inquiries'),
        automaticallyImplyLeading: false,
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed("Home_Admin");
            },
            icon: Icon(Icons.keyboard_backspace),
            label: Text("back"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 5, 66, 170),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0), // Add padding to the entire body
        child: Center(
          child: Column(
            children: [
              /*Image.asset(
                'image/e.png',
                fit: BoxFit.contain,
                width: double.infinity,
                height: 200,
              ),*/
              SizedBox(height: 20),
              FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection("admin_inquiryNS")
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Text("No data available.");
                  }

                  List<QueryDocumentSnapshot> data = snapshot.data!.docs;

                  return buildCardList(data);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCardList(List<QueryDocumentSnapshot> data) {
    return Column(
      children: data.map((doc) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: buildCard(doc),
        );
      }).toList(),
    );
  }

  Widget buildCard(QueryDocumentSnapshot doc) {
    final style = TextStyle(fontSize: 18);
    print("Inquiries: ${doc['Inquiries']}");
    print("email: ${doc['email']}");
    return InkWell(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Confirmation"),
              content: Text("Are you sure you want to delete this item?"),
              actions: <Widget>[
                TextButton(
                  child: Text("Yes"),
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection("admin_inquiryNC")
                        .doc(doc.id)
                        .delete();
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text("No"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
      child: SizedBox(
        width: 300,
        height: 80,
        child: Card(
          elevation: 4.0,
          margin: EdgeInsets.zero,
          color: Colors.blue.withOpacity(0.5),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  doc['Inquiries'] ?? '',
                  textAlign: TextAlign.center,
                  style: style,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(doc['email']),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
