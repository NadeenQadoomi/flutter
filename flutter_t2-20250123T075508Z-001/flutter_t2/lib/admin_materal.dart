// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_t2/AddLinkPage.dart';
import 'package:flutter_t2/UpdateMaterial.dart';

class admin_materal extends StatefulWidget {
  const admin_materal({Key? key});

  @override
  State<admin_materal> createState() => _admin_materalState();
}

class _admin_materalState extends State<admin_materal> {
  List<QueryDocumentSnapshot> data = [];
  List<QueryDocumentSnapshot> filteredData = [];

  getData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("material").get();
    data.addAll(querySnapshot.docs);
    setState(() {});
  }

  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(_onSearchChanged);
    getData();
  }

  void _onSearchChanged() {
    final query = searchController.text;
    setState(() {
      filteredData = data
          .where(
              (doc) => doc['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.withOpacity(0.8),
        title: Text(
          'Table materal',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed("Home_Admin");
            },
            icon: Icon(
              Icons.keyboard_backspace,
              color: Colors.blue.withOpacity(0.2),
            ),
            label: Text("back"),
          ),
        ],
      ),
      body: Stack(
        children: [
          MaterialBackground(),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextField(
                  controller: searchController,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Search for a Material',
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    suffixIcon: Icon(
                      Icons.search,
                      color: Colors.amber,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: buildSubjectListView(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildSubjectListView(BuildContext context) {
    return filteredData.isEmpty && searchController.text.isNotEmpty
        ? Center(
            child: Text(
              'No results found for "${searchController.text}"',
              style: TextStyle(color: Colors.white),
            ),
          )
        : ListView.builder(
            itemCount:
                filteredData.isNotEmpty ? filteredData.length : data.length,
            itemBuilder: (context, index) {
              final doc =
                  filteredData.isNotEmpty ? filteredData[index] : data[index];
              return buildCard(doc);
            },
          );
  }

  Widget buildCard(QueryDocumentSnapshot doc) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddLinkPage(materialDocumentId: doc.id),
        ));
      },
      onLongPress: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("Are you sure of the deleting process??"),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("clacel")),
                TextButton(
                  child: Text("edit name "),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => UpdateMaterial(
                            docid: doc.id, oldname: doc['name'])));
                  },
                ),
                TextButton(
                  child: Text("OK"),
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection("material")
                        .doc(doc.id)
                        .delete();
                    Navigator.of(context).pop(); // Close the dialog
                    Navigator.of(context).pushReplacementNamed("admin_materal");
                  },
                ),
              ],
            );
          },
        );
      },
      child: Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("image/file.jpg"),
                  ),
                ),
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doc['name'],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.ads_click,
                        color: Colors.blue,
                      ),
                      Text(
                        "edit to materal",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LessonsPage extends StatelessWidget {
  final String subject;

  const LessonsPage({required this.subject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('دروس $subject')),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          MaterialBackground(),
          Center(
            child: buildLessonsList(context),
          ),
        ],
      ),
    );
  }
}

Widget buildLessonsList(BuildContext context) {
  final List<String> lessons = [];

  return ListView.builder(
    itemCount: lessons.length,
    itemBuilder: (context, index) {
      final lesson = lessons[index];
      return MaterialCard(
        title: Text(lesson),
        trailing: GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('جاري تنزيل $lesson'),
              ),
            );
          },
          child: const Icon(Icons.file_download),
        ),
      );
    },
  );
}

class MaterialBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("image/wise.jpg"),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

final List<String> subjects = [];

class MaterialCard extends StatelessWidget {
  final Widget title;
  final Widget? trailing;

  const MaterialCard({
    Key? key,
    required this.title,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(8),
      child: ListTile(
        title: title,
        trailing: trailing,
      ),
    );
  }
}
