// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyASSsKe6OdIb6nOdDsySF4Cgecjsaz-gsI',
    appId: '1:948897074661:web:46ef9b0520d2785d6bf30c',
    messagingSenderId: '948897074661',
    projectId: 'flutterapp-22477',
    authDomain: 'flutterapp-22477.firebaseapp.com',
    storageBucket: 'flutterapp-22477.appspot.com',
    measurementId: 'G-MYQPN5KBDX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBImgscCBZqBBC83ebOkzJ24bdSYuA_3w8',
    appId: '1:948897074661:android:644ccd0c7c8c7e326bf30c',
    messagingSenderId: '948897074661',
    projectId: 'flutterapp-22477',
    storageBucket: 'flutterapp-22477.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCJAGlFq0VNWcoU7BnJ0Nljh5P-KYWyYWY',
    appId: '1:948897074661:ios:503464480220a1286bf30c',
    messagingSenderId: '948897074661',
    projectId: 'flutterapp-22477',
    storageBucket: 'flutterapp-22477.appspot.com',
    iosBundleId: 'com.example.flutterT2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCJAGlFq0VNWcoU7BnJ0Nljh5P-KYWyYWY',
    appId: '1:948897074661:ios:baf524a8620d026b6bf30c',
    messagingSenderId: '948897074661',
    projectId: 'flutterapp-22477',
    storageBucket: 'flutterapp-22477.appspot.com',
    iosBundleId: 'com.example.flutterT2.RunnerTests',
  );
}
