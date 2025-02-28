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
    apiKey: 'AIzaSyDc4RE1_FWMXmZVeGfVeF84JG4wIQRLVcs',
    appId: '1:498230445799:web:7c6c40d0cb28dc78528442',
    messagingSenderId: '498230445799',
    projectId: 'fire-auth-crud-3ef25',
    authDomain: 'fire-auth-crud-3ef25.firebaseapp.com',
    storageBucket: 'fire-auth-crud-3ef25.appspot.com',
    measurementId: 'G-4G3PE96EJ6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCrgJxp6BQf14DBMEqLqx_Xrg20LDsu8uo',
    appId: '1:498230445799:android:6cfea7d5ca09449a528442',
    messagingSenderId: '498230445799',
    projectId: 'fire-auth-crud-3ef25',
    storageBucket: 'fire-auth-crud-3ef25.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAq7pK1V-MflDJXpo7_nRRPRb9K1YJe9hI',
    appId: '1:498230445799:ios:de793ba0d11f86f3528442',
    messagingSenderId: '498230445799',
    projectId: 'fire-auth-crud-3ef25',
    storageBucket: 'fire-auth-crud-3ef25.appspot.com',
    iosBundleId: 'com.example.fireAuthCrud',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAq7pK1V-MflDJXpo7_nRRPRb9K1YJe9hI',
    appId: '1:498230445799:ios:eeda2461c7aeaa55528442',
    messagingSenderId: '498230445799',
    projectId: 'fire-auth-crud-3ef25',
    storageBucket: 'fire-auth-crud-3ef25.appspot.com',
    iosBundleId: 'com.example.fireAuthCrud.RunnerTests',
  );
}
