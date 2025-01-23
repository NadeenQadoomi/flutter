import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateVideo extends StatefulWidget {
  final String docid;
  final String oldname;
  const UpdateVideo({super.key, required this.docid, required this.oldname});

  @override
  State<UpdateVideo> createState() => _UpdateVideolState();
}

class _UpdateVideolState extends State<UpdateVideo> {
  TextEditingController name2 = TextEditingController();
  CollectionReference UpdateVideo =
      FirebaseFirestore.instance.collection('Watchlectures');
  Future<void> Updetev() {
    return UpdateVideo.doc(widget.docid)
        .update({"name": name2.text})
        .then((value) => print("video updet"))
        .catchError((error) => print("Failed to video updet: $error"));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name2.text = widget.oldname;
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
              controller: name2,
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
                  Updetev();
                  Navigator.of(context).pushReplacementNamed("admin_lectures");
                },
                child: Text("Save")),
          ],
        ),
      ),
    );
  }
}
