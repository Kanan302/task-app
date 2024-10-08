// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyB0gl16_fP6QqhgUqe5ijqmX0AcZClyV34',
    appId: '1:547295572230:web:f1f024e5822acd41f1ee87',
    messagingSenderId: '547295572230',
    projectId: 'task-app-3683e',
    authDomain: 'task-app-3683e.firebaseapp.com',
    storageBucket: 'task-app-3683e.appspot.com',
    measurementId: 'G-Z0Y5FG00C4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCXmd2Eo31BdDrAqKYuydAmD-z2UHprwLI',
    appId: '1:547295572230:android:c0a1e76cc681339af1ee87',
    messagingSenderId: '547295572230',
    projectId: 'task-app-3683e',
    storageBucket: 'task-app-3683e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCR1MNo-GIX7aytEeNwf09Z227qW3uwQ4M',
    appId: '1:547295572230:ios:645eb4668a5646a8f1ee87',
    messagingSenderId: '547295572230',
    projectId: 'task-app-3683e',
    storageBucket: 'task-app-3683e.appspot.com',
    iosBundleId: 'com.example.task',
  );
}
