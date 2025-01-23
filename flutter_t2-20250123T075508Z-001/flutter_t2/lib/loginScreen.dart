// ignore_for_file: prefer_const_constructors, unused_local_variable, use_build_context_synchronously, avoid_single_cascade_in_expression_statements, sized_box_for_whitespace, file_names, unused_catch_clause
//import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_t2/myHome.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isloding = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordHidden = true;
  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: isloding == true
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                Center(
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.black.withOpacity(0.6),
                            radius: screenSize.width * 0.15,
                            child: Image.asset(
                              "image/wise.jpg",
                              fit: BoxFit.contain,
                              height: screenSize.height,
                              width: screenSize.width,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            style: const TextStyle(color: Colors.black),
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Color.fromARGB(255, 5, 66, 170),
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: const TextStyle(
                                  color: Color.fromARGB(255, 5, 66, 170),
                                  fontSize: 18),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 5, 66, 170)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 5, 66, 170)),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  emailController.clear();
                                },
                                icon: const Icon(Icons.close,
                                    color: Color.fromARGB(255, 5, 66, 170)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18),
                            controller: passwordController,
                            keyboardType: TextInputType.text,
                            cursorColor: Color.fromARGB(255, 5, 66, 170),
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: const TextStyle(
                                  color: Color.fromARGB(255, 5, 66, 170),
                                  fontSize: 18),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 5, 66, 170)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 5, 66, 170)),
                              ),
                              suffixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      isPasswordHidden = !isPasswordHidden;
                                      setState(() {});
                                      isloding = false;
                                      setState(() {});
                                    },
                                    icon: Icon(
                                      isPasswordHidden
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Color.fromARGB(255, 5, 66, 170),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      passwordController.clear();
                                    },
                                    icon: const Icon(Icons.close,
                                        color: Color.fromARGB(255, 5, 66, 170)),
                                  ),
                                ],
                              ),
                            ),
                            obscureText: isPasswordHidden,
                          ),
                          Text(
                            errorMessage,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 16),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () async {
                              if (emailController.text ==
                                      'saberflaha078823@gmail.com' &&
                                  passwordController.text == 'Admin123') {
                                Navigator.of(context)
                                    .pushReplacementNamed("Home_Admin");
                              }
                              if (emailController.text.isEmpty ||
                                  passwordController.text.isEmpty) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Error"),
                                      content: Text(
                                          "Please enter both email and password."),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text("OK"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                                return;
                              }

                              try {
                                isloding = true;
                                setState(() {});

                                await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: emailController.text,
                                        password: passwordController.text);
                                User? user = FirebaseAuth.instance.currentUser;
                                String userName =
                                    user!.displayName ?? "No Name";
                                String email = user.email ?? "No Email";
                                String specialty = "Specialty";
                                Navigator.of(context)
                                    .pushReplacementNamed("Page1");
                              } on FirebaseAuthException catch (e) {
                                isloding = false;
                                setState(() {});
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Error"),
                                      content:
                                          Text("invalid email or password "),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text("OK"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.amber.withOpacity(0.9)),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            child: Container(
                              width: screenSize.width * 0.6,
                              height: screenSize.width * 0.1,
                              child: Center(
                                child: Text(
                                  "Log in",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MyHome()),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.amber.withOpacity(0.9)),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            child: Container(
                                width: screenSize.width * 0.6,
                                height: screenSize.width * 0.1,
                                child: Center(
                                  child: Text(
                                    "Back",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                )),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(width: 5),
                              GestureDetector(
                                onTap: () {},
                                child: InkWell(
                                  onTap: () async {
                                    await FirebaseAuth.instance
                                        .sendPasswordResetEmail(
                                            email: emailController.text);
                                  },
                                  child: const Text(
                                    "Forgot Password",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Color.fromARGB(255, 5, 66, 170)),
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
}

class SecondScreen {}
