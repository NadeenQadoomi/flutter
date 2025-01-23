// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, file_names, avoid_print, prefer_const_declarations, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_t2/PageView4.dart';
import 'package:flutter_t2/Specialties.dart';
import 'package:flutter_t2/Watchlectures.dart';
import 'package:flutter_t2/material.dart';
import 'package:flutter_t2/table.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  final List<String> imagePaths = [
    'image/materal2.jpg',
    'image/materal3.jpg',
    'image/saber1.jpeg',
    'image/IMG_8005.jpg',
    'image/saber2.jpeg'
  ];
  late String userName = '';
  late String email = '';
  late String specialty = '';
  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('accountCreationScreen')
          .where('uid', isEqualTo: uid)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          userName = querySnapshot.docs.first['UserName'];
          email = querySnapshot.docs.first['email'];
          specialty = querySnapshot.docs.first['specialty'];
        });
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<String> getUserNameFromUID(String uid) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('accountCreationScreen')
        .where('uid', isEqualTo: uid)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first['email'];
    } else {
      return "Default Name";
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color customColor = Color.fromARGB(255, 5, 66, 170);
    final Color customColor2 = Colors.amber;

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 5, 66, 170),
              ),
              accountName: Text(userName),
              accountEmail: Text(email),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('image/pe.png'),
              ),
            ),
            ListTile(
              title: Text('Specialty: $specialty',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Color.fromARGB(255, 5, 66, 170))),
            ),
            buildDrawerButton("Watch lectures", MaterialL()),
            buildDrawerButton("Materials", Material1()),
            buildDrawerButton("Lectures Schedule", AppointmentsPage()),
            buildDrawerButton("Indicative plan", Specialties()),
            buildDrawerButton("Problems facing the student", PageView4()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacementNamed("myHome");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                ),
                child: Text(
                  'Sign Out',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 5, 66, 170)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset('image/wise.jpg', height: 100),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.3),
        title: const Text("IT Library",
            style: TextStyle(
                color: Color.fromARGB(255, 5, 66, 170),
                fontWeight: FontWeight.bold)),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipOval(
                child: Container(
                  width: 40,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    "image/wise.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(16),
              child: Text(
                "Welcome to IT Library App! Explore our resources and features.",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: imagePaths.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 2),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          imagePaths[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: buildListItem(
                      context,
                      "Watch lectures",
                      customColor,
                      MaterialPageRoute(builder: (context) => MaterialL()),
                      Icons.play_arrow, () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MaterialL(),
                    ));
                  }),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: buildListItem(
                      context,
                      "Materials",
                      customColor,
                      MaterialPageRoute(builder: (context) => Material1()),
                      Icons.insert_drive_file, () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Material1(),
                    ));
                  }),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: buildListItem(
                      context,
                      " Lectures Schedule",
                      customColor,
                      MaterialPageRoute(
                          builder: (context) => AppointmentsPage()),
                      Icons.date_range, () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AppointmentsPage(),
                    ));
                  }),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: buildListItem(
                      context,
                      "Indicative plan",
                      customColor,
                      MaterialPageRoute(builder: (context) => Specialties()),
                      Icons.local_library, () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Specialties(),
                    ));
                  }),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: buildListItem(
                      context,
                      "Problems facing the student",
                      customColor2,
                      MaterialPageRoute(builder: (context) => PageView4()),
                      Icons.warning, () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PageView4(),
                    ));
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListItem(BuildContext context, String title, Color color,
      MaterialPageRoute route, IconData iconData, Function() fn) {
    return GestureDetector(
      onTap: fn,
      child: Container(
        width: 150,
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData, size: 40, color: Colors.white),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.6),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTable(List<String> headerData, List<List<String>> data) {
    List<TableRow> rows = [];

    rows.add(buildTableRow(headerData, isHeader: true));

    for (var rowData in data) {
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
          color: isHeader ? Colors.black.withOpacity(0.7) : Colors.white,
          child: Text(
            item,
            textAlign: TextAlign.center,
            style: style,
          ),
        );
      }).toList(),
    );
  }

  Widget buildDrawerButton(String title, Widget destination) {
    return ListTile(
      titleTextStyle: TextStyle(
        fontSize: 17,
        color: Color.fromARGB(255, 5, 66, 170),
        fontWeight: FontWeight.bold,
      ),
      title: Text(title),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => destination,
        ));
      },
    );
  }
}
