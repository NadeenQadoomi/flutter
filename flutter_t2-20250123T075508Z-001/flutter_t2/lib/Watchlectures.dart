// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, file_names, deprecated_member_use, avoid_print, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_t2/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MaterialL extends StatefulWidget {
  const MaterialL({Key? key});

  @override
  State<MaterialL> createState() => _MaterialLState();
}

class _MaterialLState extends State<MaterialL> {
  bool isLoading = true;
  final searchController = TextEditingController();
  List<QueryDocumentSnapshot> data = [];
  List<QueryDocumentSnapshot> filteredData = [];

  getData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("Watchlectures").get();
    data.addAll(querySnapshot.docs);
    setState(() {
      isLoading = false;
    });
  }

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
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                MaterialBackground(),
                Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: searchController,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 5, 66, 170),
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Search for lectures',
                              labelStyle: TextStyle(
                                color: Color.fromARGB(255, 5, 66, 170),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 5, 66, 170)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 5, 66, 170)),
                              ),
                              suffixIcon: Icon(
                                Icons.search,
                                color: Color.fromARGB(255, 5, 66, 170),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: buildSubjectListView(context),
                      ),
                    ],
                  ),
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
              style: TextStyle(color: Colors.black, fontSize: 30),
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
    return Card(
      color: Colors.amber.withOpacity(0.9),
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("image/viedo.webp"),
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
                    InkWell(
                      onTap: () {
                        _launchURL(doc["link"]);
                      },
                      child: Icon(
                        Icons.ads_click,
                        color: Colors.blue,
                      ),
                    ),
                    Text(
                      "Watch lectures",
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
    );
  }

  void _launchURL(String url) async {
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(
          Uri.parse(url),
        );
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching URL: $e');
      // Provide more information about the error
      showDialog(
        context:
            context, // Note: Make sure you have access to the 'context' variable here
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(
            'Could not launch URL. Please check your internet connection.\nError: $e',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}

class LessonsPage extends StatelessWidget {
  final String subject;

  LessonsPage({required this.subject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('دروس $subject'),
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
