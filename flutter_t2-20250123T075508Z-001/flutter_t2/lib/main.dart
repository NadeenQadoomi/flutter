// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_t2/HomeAdmin.dart';
import 'package:flutter_t2/Log_in_Admin.dart';
import 'package:flutter_t2/Page1.dart';
import 'package:flutter_t2/PageView4.dart';
import 'package:flutter_t2/Splash.dart';
import 'package:flutter_t2/accountCreationScreen.dart';
import 'package:flutter_t2/admin_inquiry.dart';
import 'package:flutter_t2/admin_inquiryNC.dart';
import 'package:flutter_t2/admin_inquiryNSC.dart';
import 'package:flutter_t2/admin_inquirySE.dart';
import 'package:flutter_t2/admin_lectures.dart';
import 'package:flutter_t2/admin_materal.dart';
import 'package:flutter_t2/admin_table.dart';
import 'package:flutter_t2/Computer_Science.dart';
import 'package:flutter_t2/adminproblem.dart';
import 'package:flutter_t2/firebase_options.dart';
import 'package:flutter_t2/loginScreen.dart';
import 'package:flutter_t2/myHome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print(
            '======================================User is currently signed out!');
      } else {
        print('================================User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      title: 'Login App',
      home:
          FirebaseAuth.instance.currentUser == null ? SplashScreen() : Page1(),
      routes: {
        "AccountCreationScreen": (context) => AccountCreationScreen(),
        "LoginScreen": (context) => LoginScreen(),
        "Page1": (context) => Page1(),
        "myHome": (context) => MyHome(),
        "LoginAdmain": (context) => LoginAdmain(),
        "Home_Admin": (context) => Home_Admin(),
        "table": (context) => Table(),
        "admin_materal": (context) => admin_materal(),
        "admin_table": (context) => admin_table(),
        "admin_lectures": (context) => admin_lectures(),
        "admain_inquiry": (context) => admain_inquiry(),
        "Computer_Science": (context) => Computer_Science(),
        "admain_inquirySE": (context) => admain_inquirySE(),
        "admin_inquiryNC": (context) => admin_inquiryNC(),
        "admin_inquiryNSC": (context) => admin_inquiryNSC(),
        "PageView4": (context) => PageView4(),
        "AdminIssus": (context) => AdminIssus(),
      },
    );
  }
}
