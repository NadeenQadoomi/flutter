// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({super.key});

  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 5, 66, 170),
        title: Center(child: Text('Table Lecture dates')),
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
            Center(
              child: Text(
                "The in presence teachings for this week",
                style: TextStyle(
                    color: Color.fromARGB(255, 5, 66, 170),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
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
                  'the time'
                ];

                return buildTable(headerData, data!);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTable(List<String> headerData, List<QueryDocumentSnapshot> data) {
    List<TableRow> rows = [];

    rows.add(buildTableRow(headerData, isHeader: true));

    for (var doc in data) {
      List<String> rowData = [
        doc['name3'],
        doc['name4'],
        doc['name5'],
        doc['name6'],
        doc['name7'],
      ];
      rows.add(buildTableRow(rowData));
    }

    return Table(
      border: TableBorder.all(),
      children: rows,
    );
  }

  TableRow buildTableRow(List<String> data, {bool isHeader = false}) {
    final style = TextStyle(
        fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
        fontSize: 18);
    return TableRow(
      children: data.map((item) {
        return Container(
          padding: const EdgeInsets.all(8.0),
          color: isHeader ? Colors.blue : Colors.amber.withOpacity(0.5),
          child: Text(
            item,
            textAlign: TextAlign.center,
            style: style,
          ),
        );
      }).toList(),
    );
  }
}
