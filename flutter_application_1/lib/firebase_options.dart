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
    apiKey: 'AIzaSyCtrwvbjCvc1BY7jrb5RUzx0QISct7Wqhs',
    appId: '1:665876378471:web:82055a221723e162f5f5c2',
    messagingSenderId: '665876378471',
    projectId: 'solutionchallenge-bd059',
    authDomain: 'solutionchallenge-bd059.firebaseapp.com',
    storageBucket: 'solutionchallenge-bd059.appspot.com',
    measurementId: 'G-MYGKK1350W',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDqjXKoi2qroofhSb2BW3AbQ7w27Sum07Q',
    appId: '1:665876378471:android:59a0b64399c63674f5f5c2',
    messagingSenderId: '665876378471',
    projectId: 'solutionchallenge-bd059',
    storageBucket: 'solutionchallenge-bd059.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC-jehDFfgIZEeqrF-S8gT4H4GKFkguEDU',
    appId: '1:665876378471:ios:e783b0d2c3548b69f5f5c2',
    messagingSenderId: '665876378471',
    projectId: 'solutionchallenge-bd059',
    storageBucket: 'solutionchallenge-bd059.appspot.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC-jehDFfgIZEeqrF-S8gT4H4GKFkguEDU',
    appId: '1:665876378471:ios:d37e5bb11ce3c666f5f5c2',
    messagingSenderId: '665876378471',
    projectId: 'solutionchallenge-bd059',
    storageBucket: 'solutionchallenge-bd059.appspot.com',
    iosBundleId: 'com.example.flutterApplication1.RunnerTests',
  );
}