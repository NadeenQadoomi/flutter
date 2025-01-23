// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminIssus extends StatefulWidget {
  const AdminIssus({Key? key}) : super(key: key);

  @override
  State<AdminIssus> createState() => _AdminIssuesState();
}

class _AdminIssuesState extends State<AdminIssus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 5, 66, 170),
        title: Center(child: Text(' Student problems')),
        automaticallyImplyLeading: false,
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed("Home_Admin");
            },
            icon: Icon(Icons.keyboard_backspace),
            label: Text("Back"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 5, 66, 170),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            FutureBuilder<QuerySnapshot>(
              future:
                  FirebaseFirestore.instance.collection("AdminIssues").get(),
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
    );
  }

  Widget buildCardList(List<QueryDocumentSnapshot> data) {
    return Center(
      child: Column(
        children: data.map((doc) {
          return Column(
            children: [
              buildCard(doc),
              SizedBox(height: 6),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget buildCard(QueryDocumentSnapshot doc) {
    final style = TextStyle(
      fontSize: 18,
    );

    String issueText = doc['issues'] != null ? doc['issues'] : 'No issue text';

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
                        .collection("AdminIssues")
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
        margin: EdgeInsets.all(0),
        color: Colors.blue.withOpacity(0.5),
        child: SizedBox(
          width: 300, // Set the height to 100
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  issueText,
                  textAlign: TextAlign.center,
                  style: style,
                ),
                SizedBox(height: 10),
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
