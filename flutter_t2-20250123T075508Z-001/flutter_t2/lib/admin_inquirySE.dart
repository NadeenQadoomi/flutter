// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class admain_inquirySE extends StatefulWidget {
  const admain_inquirySE({Key? key}) : super(key: key);

  @override
  State<admain_inquirySE> createState() => _AdmainInquirySEState();
}

class _AdmainInquirySEState extends State<admain_inquirySE> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 5, 66, 170),
        title: Text('S_E student  inquiries'),
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
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection("admin_inquirySE")
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
    final style = TextStyle(
      fontSize: 20,
    );

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
                        .collection("admin_inquirySE")
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
        height: 120,
        child: Card(
          elevation: 4.0,
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
                Text(
                  doc['email'] ?? '',
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
