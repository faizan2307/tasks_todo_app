// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyChiUO55sr8J7QQxf2dA21TzUH0PdEBx-g',
    appId: '1:77987794914:web:8f793ed934caf09fb533bb',
    messagingSenderId: '77987794914',
    projectId: 'clear-todo-app',
    authDomain: 'clear-todo-app.firebaseapp.com',
    storageBucket: 'clear-todo-app.appspot.com',
    measurementId: 'G-4T5FVF80QC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD7goNCN1KjOGlWrKdL-6_XqDMLqZr7vfo',
    appId: '1:77987794914:android:8015f67e359df64bb533bb',
    messagingSenderId: '77987794914',
    projectId: 'clear-todo-app',
    storageBucket: 'clear-todo-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA6lHVKeM-RdzeZR497VVvDyRLvEeDCNU8',
    appId: '1:77987794914:ios:ad15b90320416ec3b533bb',
    messagingSenderId: '77987794914',
    projectId: 'clear-todo-app',
    storageBucket: 'clear-todo-app.appspot.com',
    iosClientId: '77987794914-iv7s0ue21ge6i2k19gt4dcb0ct723fm1.apps.googleusercontent.com',
    iosBundleId: 'com.example.tasksTodoApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA6lHVKeM-RdzeZR497VVvDyRLvEeDCNU8',
    appId: '1:77987794914:ios:ad15b90320416ec3b533bb',
    messagingSenderId: '77987794914',
    projectId: 'clear-todo-app',
    storageBucket: 'clear-todo-app.appspot.com',
    iosClientId: '77987794914-iv7s0ue21ge6i2k19gt4dcb0ct723fm1.apps.googleusercontent.com',
    iosBundleId: 'com.example.tasksTodoApp',
  );
}
