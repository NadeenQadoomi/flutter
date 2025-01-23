// ignore_for_file: deprecated_member_use, use_build_context_synchronously, prefer_const_constructors, non_constant_identifier_names, use_key_in_widget_constructors, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Material1 extends StatefulWidget {
  const Material1({Key? key});

  @override
  State<Material1> createState() => _Material1State();
}

class _Material1State extends State<Material1> {
  bool isLoading = true;

  List<QueryDocumentSnapshot> data = [];
  List<QueryDocumentSnapshot> searchResults = [];

  getData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("material").get();
    data.addAll(querySnapshot.docs);
    setState(() {
      isLoading = false;
    });
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
      searchResults = data
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
                Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: TextField(
                        controller: searchController,
                        style: const TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Search for a Material',
                          labelStyle: TextStyle(
                            color: Colors.amber,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber),
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
    return (searchResults.isEmpty && searchController.text.isNotEmpty)
        ? Center(
            child: Text(
              'No results found for "${searchController.text}"',
              style: TextStyle(color: Colors.blue),
            ),
          )
        : ListView.builder(
            itemCount:
                searchResults.isNotEmpty ? searchResults.length : data.length,
            itemBuilder: (context, index) {
              final doc =
                  searchResults.isNotEmpty ? searchResults[index] : data[index];

              return buildCard(doc);
            },
          );
  }

  Widget buildCard(QueryDocumentSnapshot doc) {
    return Card(
      color: Colors.blue.withOpacity(0.9),
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
                    InkWell(
                      onTap: () {
                        _launchURL(
                          doc['link'],
                        );
                      },
                      child: Icon(
                        Icons.ads_click,
                        color: Colors.amber,
                      ),
                    ),
                    Text(
                      "go to materal ",
                      style: TextStyle(
                        color: Colors.amber,
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
  /*if (await canLaunchUrl(Uri.parse('any Url'))) {
      await launchUrl(
        Uri.parse('any Url'),
      );
    }else{
      //Set error handler
    } */

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
