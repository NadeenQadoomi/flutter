// ignore_for_file: avoid_print, non_constant_identifier_names, invalid_return_type_for_catch_error, prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddLinkPpage2 extends StatefulWidget {
  final String WatchlecturesDocRef;

  const AddLinkPpage2({
    Key? key,
    required this.WatchlecturesDocRef,
  });

  @override
  _AddLinkPpage2State createState() => _AddLinkPpage2State();
}

class _AddLinkPpage2State extends State<AddLinkPpage2> {
  TextEditingController linkController2 = TextEditingController();
  CollectionReference Watchlectures =
      FirebaseFirestore.instance.collection('Watchlectures');

  Future<void> addlink() async {
    if (linkController2.text.isEmpty) {
      showSnackBar("Please enter a link before saving.");
      return;
    }
    await Watchlectures.doc(widget.WatchlecturesDocRef).update({
      "link": linkController2.text,
    }).then((value) {
      print("video Added");
      showSnackBar("Link Added");
      setState(() {
        linkController2.clear();
      });
    }).catchError((error) => print("Failed to add video: $error"));
  }

  Future<void> deleteLink() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(" Confirm deletion"),
          content: Text("Are you sure you want to delete the link?"),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Delete"),
              onPressed: () async {
                await Watchlectures.doc(widget.WatchlecturesDocRef).update({
                  "link": FieldValue.delete(),
                });
                print("video Deleted");
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Link'),
        backgroundColor: Color.fromARGB(255, 5, 66, 170),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: linkController2,
              decoration: InputDecoration(
                labelText: 'Enter the link',
                labelStyle:
                    const TextStyle(color: Color.fromARGB(255, 5, 66, 170)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 5, 66, 170)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 5, 66, 170)),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              ),
              keyboardType: TextInputType.url,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    addlink();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 5, 66, 170),
                  ),
                  child: Text('Save'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditLinkPage2(
                          WatchlecturesDocRef: widget.WatchlecturesDocRef,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 5, 66, 170),
                  ),
                  child: Text('Edit Link'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    deleteLink();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 5, 66, 170),
                  ),
                  child: Text('Delete Link'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class EditLinkPage2 extends StatefulWidget {
  final String WatchlecturesDocRef;

  const EditLinkPage2({
    Key? key,
    required this.WatchlecturesDocRef,
  });

  @override
  _EditLinkPage2State createState() => _EditLinkPage2State();
}

class _EditLinkPage2State extends State<EditLinkPage2> {
  TextEditingController linkController = TextEditingController();
  CollectionReference Watchlectures =
      FirebaseFirestore.instance.collection('Watchlectures');

  Future<void> updateLink() {
    return Watchlectures.doc(widget.WatchlecturesDocRef).update({
      "link": linkController.text,
    }).then((value) {
      print("Link Updated");
      Navigator.of(context).pop();
    }).catchError((error) => print("Failed to update link: $error"));
  }

  @override
  void initState() {
    super.initState();
    Watchlectures.doc(widget.WatchlecturesDocRef).get().then((snapshot) {
      if (snapshot.exists) {
        setState(() {
          linkController.text = snapshot.get("link") ?? "";
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Link'),
        backgroundColor: Color.fromARGB(255, 5, 66, 170),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: linkController,
              decoration: InputDecoration(
                labelText: 'Enter the link',
                labelStyle:
                    const TextStyle(color: Color.fromARGB(255, 5, 66, 170)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 5, 66, 170)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 5, 66, 170)),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              ),
              keyboardType: TextInputType.url,
            ),
            SizedBox(height: 16),
            ElevatedButton(
                onPressed: () {
                  updateLink();
                  Navigator.of(context).pop();

                  Navigator.of(context).pushReplacementNamed("admin_lectures");
                },
                child: Text('Save'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 5, 66, 170),
                )),
          ],
        ),
      ),
    );
  }
}
