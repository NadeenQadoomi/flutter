// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, file_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_t2/Network_security_and_confidentiality.dart';
import 'package:flutter_t2/Network_systems.dart';
import 'package:flutter_t2/Software_engineering.dart';
import 'package:flutter_t2/Computer_Science.dart';

class Specialties extends StatelessWidget {
  const Specialties({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 5, 66, 170),
        title: Center(child: Text("Indicative Plan")),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("image/wise.jpg"),
            fit: BoxFit.contain,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Guidance plans for all specialties",
                  style: TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                SpecializationContainer(
                  title: "Computer Science",
                  color: Color.fromARGB(255, 5, 66, 170),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Computer_Science()),
                    );
                  },
                ),
                SpecializationContainer(
                  title: "Software Engineering",
                  color: Color.fromARGB(255, 5, 66, 170),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Software_Engineering()),
                    );
                  },
                ),
                SpecializationContainer(
                  title: "Network Security",
                  color: Color.fromARGB(255, 5, 66, 170),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Network_security_and_confidentiality(),
                      ),
                    );
                  },
                ),
                SpecializationContainer(
                  title: "Network Systems",
                  color: Color.fromARGB(255, 5, 66, 170),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Network_systems()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SpecializationContainer2 extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback onPressed;

  SpecializationContainer2(
      {Key? key,
      required this.title,
      required this.color,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 100,
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.8),
              spreadRadius: 2,
              blurRadius: 10,
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}

class SpecializationContainer extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback onPressed;

  SpecializationContainer(
      {super.key,
      required this.title,
      required this.color,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.white,
              spreadRadius: 5,
              blurRadius: 10,
            ),
          ],
        ),
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
      ),
    );
  }
}

class SpecializationDetails extends StatelessWidget {
  final String title;

  SpecializationDetails(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(title),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("image/specialization_background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "تفاصيل $title",
                style: const TextStyle(color: Colors.white, fontSize: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
