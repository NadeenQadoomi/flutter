// ignore_for_file: equal_keys_in_map, prefer_const_constructors, avoid_print, non_constant_identifier_names, camel_case_types, avoid_unnecessary_containers, file_names, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home_Admin extends StatefulWidget {
  const Home_Admin({super.key});

  @override
  State<Home_Admin> createState() => _Home_AdminState();
}

class _Home_AdminState extends State<Home_Admin> {
  TextEditingController name = TextEditingController();
  CollectionReference material =
      FirebaseFirestore.instance.collection('material');
  TextEditingController name2 = TextEditingController();
  CollectionReference Watchlectures =
      FirebaseFirestore.instance.collection('Watchlectures');

  TextEditingController name3 = TextEditingController();
  TextEditingController name4 = TextEditingController();
  TextEditingController name5 = TextEditingController();
  TextEditingController name6 = TextEditingController();
  TextEditingController name7 = TextEditingController();
  CollectionReference table = FirebaseFirestore.instance.collection('table');

  Future<void> addUser() {
    return material
        .add({"name": name.text, "id": FirebaseAuth.instance.currentUser?.uid})
        .then((value) => print("material Added"))
        .catchError((error) => print("Failed to add material: $error"));
  }

  Future<void> addvideo() {
    return Watchlectures.add(
            {"name": name2.text, "id": FirebaseAuth.instance.currentUser?.uid})
        .then((value) => print("video Added"))
        .catchError((error) => print("Failed to add video: $error"));
  }

  Future<void> addtable() {
    return table
        .add({
          "name3": name3.text,
          "id": FirebaseAuth.instance.currentUser?.uid,
          "name4": name4.text,
          "name5": name5.text,
          "name6": name6.text,
          "name7": name7.text,
        })
        .then((value) => print(" Added table"))
        .catchError((error) => print("Failed to add table: $error"));
  }

  Future<List<Map<String, dynamic>>> getAllUsersInfo() async {
    try {
      QuerySnapshot<Map<String, dynamic>> usersSnapshot =
          await FirebaseFirestore.instance
              .collection('accountCreationScreen')
              .get();

      List<Map<String, dynamic>> usersInfoList = [];

      for (QueryDocumentSnapshot<Map<String, dynamic>> userSnapshot
          in usersSnapshot.docs) {
        Map<String, dynamic> userInfo = userSnapshot.data();
        usersInfoList.add(userInfo);
      }

      return usersInfoList;
    } catch (e) {
      print('Error fetching users data: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacementNamed("myHome");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(160, 162, 164, 1),
              ),
              child: Text('Sign Out'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Center(
          child: Text(
            "Admainstretar",
            style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 5, 66, 170),
                fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Color.fromRGBO(160, 162, 164, 1),
      ),
      body: Container(
        color: Colors.white.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: ListView(
            children: [
              Container(
                //color: Colors.black.withOpacity(0.5),
                child: Column(
                  children: [
                    Text(
                      " add and delete  and edit to Materials",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 5, 66, 170),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: name,
                      //   decoration: InputDecoration(labelText: 'اكتب هنا'),
                      decoration: const InputDecoration(
                        labelText: 'add name Material',
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 5, 66, 170),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 5, 66, 170),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 5, 66, 170),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 5, 66, 170),
                          ),
                          onPressed: () {
                            if (name.text.isNotEmpty) {
                              addUser();
                              name.clear();
                            } else {
                              _showErrorDialog(
                                  context, 'Please add name Material.');
                            }
                          },
                          child: Text('Add Material'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 5, 66, 170),
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed("admin_materal");
                          },
                          child: Text(' Materials '),
                        ),
                      ],
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: double.infinity,
                            child: Container(
                              height: 2,
                              color: Color.fromRGBO(160, 162, 164, 1),
                              margin: EdgeInsets.symmetric(vertical: 10),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              "",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(160, 162, 164, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      " add and delete  and edit to lectures",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 5, 66, 170),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: name2,
                      decoration: const InputDecoration(
                        labelText: 'add name lecture',
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 5, 66, 170),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 5, 66, 170),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 5, 66, 170),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 5, 66, 170),
                          ),
                          onPressed: () {
                            if (name2.text.isNotEmpty) {
                              addvideo();
                              name2.clear();
                            } else {
                              _showErrorDialog(
                                  context, 'Please add  name lecture .');
                            }
                          },
                          child: Text('Add lecture'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 5, 66, 170),
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed("admin_lectures");
                          },
                          child: Text(' Material lectures '),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: double.infinity,
                            child: Container(
                              height: 2,
                              color: Color.fromRGBO(160, 162, 164, 1),
                              margin: EdgeInsets.symmetric(vertical: 10),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              "",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(160, 162, 164, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      " add and delete  and edit to Schedule",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 5, 66, 170),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: name3,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 5, 66, 170),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 5, 66, 170),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 5, 66, 170),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: name4,
                      decoration: const InputDecoration(
                        labelText: 'enter your materal',
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 5, 66, 170),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 5, 66, 170),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 5, 66, 170),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: name5,
                      decoration: const InputDecoration(
                        labelText: 'enter the topic',
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 5, 66, 170),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 5, 66, 170),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 5, 66, 170),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: name6,
                      decoration: const InputDecoration(
                        labelText: 'Enter the hall number',
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 5, 66, 170),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 5, 66, 170),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 5, 66, 170),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: name7,
                      decoration: const InputDecoration(
                        labelText: 'Lecture time',
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 5, 66, 170),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 5, 66, 170),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 5, 66, 170),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 5, 66, 170),
                      ),
                      onPressed: () {
                        if (name3.text.isNotEmpty &&
                            name4.text.isNotEmpty &&
                            name5.text.isNotEmpty &&
                            name6.text.isNotEmpty &&
                            name6.text.isNotEmpty) {
                          addtable();
                          name3.clear();
                          name4.clear();
                          name5.clear();
                          name6.clear();
                          name7.clear();
                        } else {
                          _showErrorDialog(context,
                              'Please check that all fields are filled out.');
                        }
                      },
                      child: Text('Add Schedule'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 5, 66, 170),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed("admin_table");
                      },
                      child: Text('Schedule lectures  '),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: double.infinity,
                            child: Container(
                              height: 2,
                              color: Color.fromRGBO(160, 162, 164, 1),
                              margin: EdgeInsets.symmetric(vertical: 10),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              "",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(160, 162, 164, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 5, 66, 170),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed("AdminIssus");
                      },
                      child: Text('Table of problems'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 5, 66, 170),
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed("admain_inquiry");
                          },
                          child: Text('icon admain_inquiry '),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 5, 66, 170),
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed("admain_inquirySE");
                          },
                          child: Text('icon admain_inquirySE '),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 5, 66, 170),
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed("admin_inquiryNSC");
                          },
                          child: Text('icon admain_inquiryNSC '),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 5, 66, 170),
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed("admin_inquiryNC");
                          },
                          child: Text('icon admain_inquiryNS '),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 5, 66, 170),
                      ),
                      onPressed: () async {
                        List<Map<String, dynamic>> allUsersInfo =
                            await getAllUsersInfo();

                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                'All Users Information',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              content: Container(
                                width: double.maxFinite,
                                child: ListView(
                                  shrinkWrap: true,
                                  children: allUsersInfo.map((userInfo) {
                                    return Card(
                                      elevation: 3,
                                      margin: EdgeInsets.symmetric(vertical: 8),
                                      child: ListTile(
                                        title: Text(
                                          'UserName: ${userInfo['UserName']}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Email: ${userInfo['email']}'),
                                            Text(
                                                'Specialty: ${userInfo['specialty']}'),
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Close',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text('Show All Users Information'),
                    ),

                    /*   ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed("AdminIssus");
                      },
                      child: Text('icon adminissus '),
                    ),*/
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
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
