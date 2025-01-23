// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_t2/UpbeteTable.dart';

class admin_table extends StatefulWidget {
  const admin_table({super.key});

  @override
  State<admin_table> createState() => _admin_tableState();
}

class _admin_tableState extends State<admin_table> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 5, 66, 170),
        title: Text(
          'Table Lecture dates',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        actions: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 5, 66, 170),
            ),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed("Home_Admin");
            },
            icon: Icon(Icons.keyboard_backspace),
            label: Text("back"),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'image/wise.jpg',
              fit: BoxFit.contain,
              width: double.infinity,
              height: 200,
            ),
            SizedBox(height: 20),
            FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection("table").get(),
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

                List<QueryDocumentSnapshot<Object?>>? data =
                    snapshot.data?.docs;
                List<String> headerData = [
                  'name',
                  'material',
                  'Explanation topic',
                  'Hall number',
                  'the time',
                ];

                return buildCardList(headerData, data!);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCardList(
      List<String> headerData, List<QueryDocumentSnapshot> data) {
    return Column(
      children: [
        buildCard(context, headerData, null, isHeader: true),
        ...data.map((doc) {
          List<String> rowData = [
            doc['name3'],
            doc['name4'],
            doc['name5'],
            doc['name6'],
            doc['name7'],
          ];
          return buildCard(context, rowData, doc.id);
        }).toList(),
      ],
    );
  }

  Widget buildCard(BuildContext context, List<String> data, String? docId,
      {bool isHeader = false}) {
    final style = TextStyle(
        fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
        fontSize: 18);
    return InkWell(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Confirmation"),
              content: Text("Are you sure of the deleting process?"),
              actions: <Widget>[
                TextButton(
                  child: Text("Delete"),
                  onPressed: () async {
                    if (docId != null) {
                      await FirebaseFirestore.instance
                          .collection("table")
                          .doc(docId)
                          .delete();
                      Navigator.of(context).pop();
                    }
                  },
                ),
                TextButton(
                  child: Text("Edit"),
                  onPressed: () {
                    if (docId != null) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => UpdeteTABLE(
                          docid: docId,
                          oldname: data[0],
                          oldname2: data[1],
                          oldname3: data[2],
                          oldname4: data[3],
                          oldname5: data[4],
                        ),
                      ));
                    }
                  },
                ),
              ],
            );
          },
        );
      },
      child: Card(
        margin: EdgeInsets.all(8.0),
        color: isHeader ? Color.fromARGB(255, 21, 79, 178) : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: data.map((item) {
              return Expanded(
                child: Text(
                  item,
                  textAlign: TextAlign.center,
                  style: style,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
