// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UpdeteTABLE extends StatefulWidget {
  final String docid;
  final String oldname;
  final String oldname2;
  final String oldname3;
  final String oldname4;
  final String oldname5;

  const UpdeteTABLE({
    Key? key,
    required this.docid,
    required this.oldname,
    required this.oldname2,
    required this.oldname3,
    required this.oldname4,
    required this.oldname5,
  }) : super(key: key);

  @override
  State<UpdeteTABLE> createState() => _UpdateTableState();
}

class _UpdateTableState extends State<UpdeteTABLE> {
  TextEditingController name3 = TextEditingController();
  TextEditingController name4 = TextEditingController();
  TextEditingController name5 = TextEditingController();
  TextEditingController name6 = TextEditingController();
  TextEditingController name7 = TextEditingController();

  CollectionReference table = FirebaseFirestore.instance.collection('table');

  @override
  void initState() {
    super.initState();
    name3.text = widget.oldname;
    name4.text = widget.oldname2;
    name5.text = widget.oldname3;
    name6.text = widget.oldname4;
    name7.text = widget.oldname5;
  }

  Future<void> updateTable() async {
    try {
      await table.doc(widget.docid).update({
        "name3": name3.text,
        "name4": name4.text,
        "name5": name5.text,
        "name6": name6.text,
        "name7": name7.text,
        "id": FirebaseAuth.instance.currentUser?.uid,
      });

      print("Table updated successfully");
    } catch (error) {
      print("Failed to update table: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Table'),
        backgroundColor: Color.fromARGB(255, 5, 66, 170),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTextField('Name:', name3),
              buildTextField('Material:', name4),
              buildTextField('Explanation Topic:', name5),
              buildTextField('Hall Number:', name6),
              buildTextField('The Time:', name7),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  updateTable();
                  Navigator.of(context).pushReplacementNamed("admin_table");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(
                      255, 69, 59, 255), // Change to yellow color
                ),
                child: Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
