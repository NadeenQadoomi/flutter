// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:flutter_t2/accountCreationScreen.dart';
import 'package:flutter_t2/loginScreen.dart';

class MyHome extends StatelessWidget {
  const MyHome({Key? key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Image.asset(
            "image/wise.jpg",
            fit: BoxFit.contain,
            height: screenSize.height,
            width: screenSize.width,
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              color: Colors.black.withOpacity(0.7),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Welcome",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenSize.width * 0.1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.03,
                  ),
                  Text(
                    "Our application offers you many useful \nservices to help you in your academic journey!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenSize.width * 0.045,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenSize.height * 0.06),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return const LoginScreen();
                          },
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.white,
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "     Log in      ",
                        style: TextStyle(
                          color: Color.fromARGB(255, 5, 66, 170),
                          fontSize: screenSize.width * 0.07,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.03),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return AccountCreationScreen();
                          },
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.white,
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "  Registration ",
                        style: TextStyle(
                          color: Color.fromARGB(255, 5, 66, 170),
                          fontSize: screenSize.width * 0.06,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.03),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
