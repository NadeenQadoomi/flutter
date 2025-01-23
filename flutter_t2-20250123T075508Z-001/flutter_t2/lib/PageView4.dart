// ignore_for_file: file_names, avoid_print, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PageView4 extends StatefulWidget {
  const PageView4({super.key});

  @override
  State<PageView4> createState() => _PageView4State();
}

class _PageView4State extends State<PageView4> {
  final TextEditingController issuesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference adminIssues =
        FirebaseFirestore.instance.collection('AdminIssues');

    Future<void> addIssue() {
      String text = issuesController.text.trim();
      if (text.isNotEmpty) {
        return adminIssues
            .add({
              "issues": text,
              "id": FirebaseAuth.instance.currentUser!.uid,
              "email": FirebaseAuth.instance.currentUser!.email
            })
            .then((value) => print("Issue Added"))
            .catchError((error) => print("Failed to add issue: $error"));
      } else {
        return Future.error("Empty message");
      }
    }

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 5, 66, 170),
          title: Text("problem")),
      body: PageView(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("image/wise.jpg"),
                fit: BoxFit.contain,
              ),
            ),
            padding: const EdgeInsets.all(0.0),
            child: Container(
              // color: Colors.blue.withOpacity(0.3),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Welcome to our app',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Enter the problem you are facing and specify its type (subject, lecture, etc.)',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: issuesController,
                        textAlign: TextAlign.left,
                        textDirection: TextDirection.rtl,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Enter problem text',
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber),
                          ),
                        ),
                        style: TextStyle(color: Colors.black),
                        onChanged: (text) {
                          print('Input text: $text');
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            addIssue().then((_) {
                              _showThankYouDialog(context, 'Enter');
                            }).catchError((error) {
                              _showErrorDialog(context, error.toString());
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                          ),
                          child: const Text(
                            '  send  ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 5, 66, 170),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showThankYouDialog(BuildContext context, String buttonText) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thanks!'),
          content: Text('The problem will be resolved as soon as possible'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                issuesController.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(BuildContext context, String error) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text('An error occurred while submitting the issue: $error'),
          actions: <Widget>[
            TextButton(
              child: const Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
