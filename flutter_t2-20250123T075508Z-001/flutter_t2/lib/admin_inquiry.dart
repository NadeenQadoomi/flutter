// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class admain_inquiry extends StatefulWidget {
  const admain_inquiry({Key? key}) : super(key: key);

  @override
  State<admain_inquiry> createState() => _admain_inquiryState();
}

class _admain_inquiryState extends State<admain_inquiry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 5, 66, 170),
        title: Text('C_S student inquiries'),
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
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection("admin_inquiry")
                    .get(),
                builder: (context, snapshot) {
                  print(snapshot.data);
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
        return Column(
          children: [
            buildCard(doc),
            SizedBox(
              height: 3,
            )
          ],
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
                        .collection("admain_inquiry")
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
      child: Card(
        elevation: 4.0,
        margin: EdgeInsets.all(8.0),
        color: Colors.blue.withOpacity(0.5),
        child: SizedBox(
          width: 300,
          height: 80,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
                Text(
                  doc['email'],
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
