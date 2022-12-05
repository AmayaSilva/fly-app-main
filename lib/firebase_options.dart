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
    apiKey: 'AIzaSyBg-1NzMxX195F7f3lKVR_q_24GezZuM9U',
    appId: '1:176650099472:web:dcf9c1cf3be2b9b5092395',
    messagingSenderId: '176650099472',
    projectId: 'flyapp-9dc12',
    authDomain: 'flyapp-9dc12.firebaseapp.com',
    storageBucket: 'flyapp-9dc12.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCUHktcEWD9LLWhfpwoSC21oUB0gRMoA6c',
    appId: '1:176650099472:android:214731a94160294f092395',
    messagingSenderId: '176650099472',
    projectId: 'flyapp-9dc12',
    storageBucket: 'flyapp-9dc12.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA5iDA4aKgAI2RStxYNkUzLl_LBEw3K5-4',
    appId: '1:176650099472:ios:034603d659520b4f092395',
    messagingSenderId: '176650099472',
    projectId: 'flyapp-9dc12',
    storageBucket: 'flyapp-9dc12.appspot.com',
    iosClientId: '176650099472-msu186bjels99ucnmd6599d0c9vehu60.apps.googleusercontent.com',
    iosBundleId: 'com.example.flyApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA5iDA4aKgAI2RStxYNkUzLl_LBEw3K5-4',
    appId: '1:176650099472:ios:034603d659520b4f092395',
    messagingSenderId: '176650099472',
    projectId: 'flyapp-9dc12',
    storageBucket: 'flyapp-9dc12.appspot.com',
    iosClientId: '176650099472-msu186bjels99ucnmd6599d0c9vehu60.apps.googleusercontent.com',
    iosBundleId: 'com.example.flyApp',
  );
}
