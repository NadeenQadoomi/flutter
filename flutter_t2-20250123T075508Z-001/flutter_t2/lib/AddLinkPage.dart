// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, use_key_in_widget_constructors, avoid_print, file_names, library_private_types_in_public_api, invalid_return_type_for_catch_error, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditLinkPage extends StatefulWidget {
  final String materialDocumentId;

  const EditLinkPage({Key? key, required this.materialDocumentId});

  @override
  _EditLinkPageState createState() => _EditLinkPageState();
}

class _EditLinkPageState extends State<EditLinkPage> {
  CollectionReference materialCollection =
      FirebaseFirestore.instance.collection('material');
  TextEditingController linkController = TextEditingController();

  Future<void> updateLink() async {
    await materialCollection.doc(widget.materialDocumentId).update({
      "link": linkController.text,
    });

    print("Link Updated");
  }

  @override
  void initState() {
    super.initState();
    materialCollection.doc(widget.materialDocumentId).get().then((snapshot) {
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
              onPressed: () async {
                await updateLink();
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed("admin_material");
              },
              child: Text('Save'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 5, 66, 170),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddLinkPage extends StatefulWidget {
  final String materialDocumentId;

  const AddLinkPage({Key? key, required this.materialDocumentId});

  @override
  _AddLinkPageState createState() => _AddLinkPageState();
}

class _AddLinkPageState extends State<AddLinkPage> {
  CollectionReference materialCollection =
      FirebaseFirestore.instance.collection('material');
  TextEditingController linkController = TextEditingController();

  Future<void> deleteLink() async {
    await materialCollection.doc(widget.materialDocumentId).update({
      "link": FieldValue.delete(),
    });

    print("Link Deleted");
    Navigator.of(context).pop();
  }

  Future<void> addLink() async {
    if (linkController.text.isEmpty) {
      showSnackBar("Please enter a link before saving.");
      return;
    }

    await materialCollection.doc(widget.materialDocumentId).update({
      "link": linkController.text,
    }).then((value) {
      print("Link Added");
      showSnackBar("Link Added");
      setState(() {
        linkController.clear();
      });
    }).catchError((error) => print("Failed to add link: $error"));
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await addLink();
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
                        builder: (context) => EditLinkPage(
                          materialDocumentId: widget.materialDocumentId,
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
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Confirm Deletion"),
                          content: Text("Do you want to delete the link?"),
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
                                await deleteLink();
                                Navigator.of(context).pop();
                                Navigator.of(context)
                                    .pushReplacementNamed("admin_material");
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 5, 66, 170),
                  ),
                  child: Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
