// ignore_for_file: unused_local_variable, sort_child_properties_last, use_build_context_synchronously, prefer_const_constructors, use_key_in_widget_constructors, avoid_print, file_names, prefer_is_not_empty, non_constant_identifier_names, avoid_unnecessary_containers, prefer_typing_uninitialized_variables, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountCreationScreen extends StatefulWidget {
  const AccountCreationScreen({Key? key});

  @override
  State<AccountCreationScreen> createState() => _AccountCreationScreenState();
}

class _AccountCreationScreenState extends State<AccountCreationScreen> {
  bool isloding = false;
  String userName = "";
  String email = "";
  String specialty = "";

  TextEditingController UserNameController = TextEditingController();
  TextEditingController specialtyNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  CollectionReference accountCreationScreen =
      FirebaseFirestore.instance.collection('accountCreationScreen');
  Future<void> addinfo() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      await userCredential.user!.sendEmailVerification();

      await accountCreationScreen.add({
        "uid": userCredential.user!.uid,
        "UserName": UserNameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "specialty": specialtyNameController.text,
      });

      await accountCreationScreen.add({
        "uid": userCredential.user!.uid,
        "UserName": UserNameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "specialty": specialtyNameController.text,
      });

      setState(() {
        userName = UserNameController.text;
        email = emailController.text;
        specialty = specialtyNameController.text;
      });

      print("info added successfully");
    } catch (error) {
      print("Failed to add info: $error");
    }
  }

  bool isPasswordHidden = true;
  int maxLength = 12;
  int currentLength = 0;

  String? selectedSpecialization;

  @override
  Widget build(BuildContext context) {
    var screenSize;
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black,
        backgroundColor: Color.fromARGB(255, 5, 66, 170),
        title: const Center(
          child: Text(
            'Create Account',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: isloding == true
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 30),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: ListView(
                    physics: const ClampingScrollPhysics(),
                    children: <Widget>[
                      // First Name TextFormField
                      Center(
                        child: Image.asset("image/wise.jpg",
                            fit: BoxFit.cover, height: 100, width: 100),
                      ),
                      const SizedBox(height: 70.0),

                      TextFormField(
                        controller: UserNameController,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 5, 66, 170),
                            fontSize: 20),
                        decoration: InputDecoration(
                          labelText: 'User Name',
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.4),
                          labelStyle: const TextStyle(
                              color: Color.fromARGB(255, 5, 66, 170)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 5, 66, 170)),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 5, 66, 170))),
                        ),
                      ),
                      const SizedBox(height: 16.0),

                      // Email TextFormField
                      TextFormField(
                        controller: emailController,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 5, 66, 170),
                            fontSize: 20),
                        autovalidateMode: AutovalidateMode.always,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.4),
                          labelStyle: const TextStyle(
                              color: Color.fromARGB(255, 5, 66, 170)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 5, 66, 170)),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 5, 66, 170))),
                        ),
                      ),
                      const SizedBox(height: 16.0),

                      // Password TextFormField
                      TextFormField(
                        controller: passwordController,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 5, 66, 170),
                            fontSize: 20),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.4),
                          labelStyle: const TextStyle(
                              color: Color.fromARGB(255, 5, 66, 170),
                              fontSize: 20),
                          enabledBorder: OutlineInputBorder(
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
                                },
                                icon: Icon(
                                  isPasswordHidden
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 5, 66, 170))),
                        ),
                        obscureText: isPasswordHidden,
                        //  maxLength: 10,
                      ),
                      const SizedBox(height: 15),

                      TextFormField(
                        controller: specialtyNameController,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 5, 66, 170),
                            fontSize: 20),
                        decoration: InputDecoration(
                          labelText: ' Choose your specialty',
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.4),
                          labelStyle: const TextStyle(
                              color: Color.fromARGB(255, 5, 66, 170)),
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
                        ),
                      ),
                      const SizedBox(height: 70),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacementNamed("myHome");
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: Colors.amber,
                              ),
                              width: 160,
                              height: 50,
                              child: Center(
                                child: Text(
                                  "back",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color:
                                          Color.fromARGB(255, 246, 246, 247)),
                                ),
                              ),
                            ),
                          ),
                          MaterialButton(
                            onPressed: () async {
                              if (UserNameController.text.isEmpty ||
                                  emailController.text.isEmpty ||
                                  !isPasswordValid(passwordController.text) ||
                                  specialtyNameController.text.isEmpty) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Error"),
                                      content: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            "Make sure you have entered valid information.",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            "Password should contain at least one letter, one number, and have a minimum length of 6.",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
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
                                QuerySnapshot<Map<String, dynamic>> getAll =
                                    await FirebaseFirestore.instance
                                        .collection("accountCreationScreen")
                                        .get();
                                List<String> allemails = [];
                                for (QueryDocumentSnapshot<
                                    Map<String, dynamic>> doc in getAll.docs) {
                                  allemails.add(doc.data()["email"]);
                                }
                                if (allemails.contains(emailController.text)) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Error"),
                                        content: Text(
                                            "The email is already registered"),
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
                                } else {
                                  await addinfo();
                                  if (FirebaseAuth
                                      .instance.currentUser!.emailVerified) {
                                    Navigator.of(context)
                                        .pushReplacementNamed("Page1");
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                              "Do not close this message!"),
                                          content: Text(
                                              "A verification email has been sent to $email. Please check your email and click on the verification link."),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text("OK"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                // To login
                                                Navigator.of(context)
                                                    .pushNamed("Page1");
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                }
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'weak-password') {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Error"),
                                        content: Text(
                                            "Weak password. Please choose a stronger password."),
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
                                } else if (e.code == 'email-already-in-use') {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Error"),
                                        content: Text(
                                            "The email address is already in use."),
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
                                } else {
                                  // Generic error message for other FirebaseAuthExceptions
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Authentication Error"),
                                        content: Text(
                                            "An error occurred during authentication. Please try again."),
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
                              } catch (e) {
                                print(e);
                              } finally {
                                isloding = false;
                                setState(() {});
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: Colors.amber,
                              ),
                              width: 160,
                              height: 50,
                              child: Center(
                                child: const Text(
                                  'Registration ',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            textColor: Color.fromARGB(255, 250, 251, 251),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
//يجب أن تحتوي كلمة المرور على حرف واحد ورقم واحد على الأقل، والحد الأدنى لطولها هو 6

  bool isPasswordValid(String password) {
    final hasLetter = RegExp(r'[a-zA-Z]').hasMatch(password);
    final hasNumber = RegExp(r'[0-9]').hasMatch(password);
    final isLengthValid = password.length >= 6;

    return hasLetter && hasNumber && isLengthValid;
  }
}
