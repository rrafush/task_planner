// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:simple_to_do_app/env/env.dart';

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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: Env.webApiKey,
    appId: '1:745289852436:web:b75600e5dc100f728fe901',
    messagingSenderId: '745289852436',
    projectId: 'task-planner-30a7f',
    authDomain: 'task-planner-30a7f.firebaseapp.com',
    storageBucket: 'task-planner-30a7f.firebasestorage.app',
    measurementId: 'G-0MEEJ5F9X5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: Env.androidApiKey,
    appId: '1:745289852436:android:b6dad5bdff4e0b3f8fe901',
    messagingSenderId: '745289852436',
    projectId: 'task-planner-30a7f',
    storageBucket: 'task-planner-30a7f.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: Env.iosApiKey,
    appId: '1:745289852436:ios:5e8a61871361cafb8fe901',
    messagingSenderId: '745289852436',
    projectId: 'task-planner-30a7f',
    storageBucket: 'task-planner-30a7f.firebasestorage.app',
    iosBundleId: 'com.example.simpleToDoApp',
  );
}