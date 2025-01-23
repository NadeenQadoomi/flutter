// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateMaterial extends StatefulWidget {
  final String docid;
  final String oldname;
  const UpdateMaterial({super.key, required this.docid, required this.oldname});

  @override
  State<UpdateMaterial> createState() => _UpdateMaterialState();
}

class _UpdateMaterialState extends State<UpdateMaterial> {
  TextEditingController name = TextEditingController();
  CollectionReference UpdateMaterial =
      FirebaseFirestore.instance.collection('material');
  Future<void> Updete() {
    return UpdateMaterial.doc(widget.docid)
        .update({"name": name.text})
        .then((value) => print("material update"))
        .catchError((error) => print("Failed to update : $error"));
  }

  @override
  void initState() {
    super.initState();
    name.text = widget.oldname;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 100, 20, 30),
        child: Column(
          children: [
            TextFormField(
              style: const TextStyle(color: Colors.black),
              controller: name,
              keyboardType: TextInputType.emailAddress,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                labelText: 'Updete',
                labelStyle: const TextStyle(color: Colors.black, fontSize: 18),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.black),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  Updete();
                  Navigator.of(context).pushReplacementNamed("admin_materal");
                },
                child: Text("Save")),
          ],
        ),
      ),
    );
  }
}
