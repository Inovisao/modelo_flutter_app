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
    apiKey: 'AIzaSyAFT04BxjlC-fN9_CgossmgYOBRr40YWo0',
    appId: '1:1086776185649:web:1ba1be595d4dafb74bd610',
    messagingSenderId: '1086776185649',
    projectId: 'pdb-photo-project',
    authDomain: 'pdb-photo-project.firebaseapp.com',
    storageBucket: 'pdb-photo-project.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDxAlqiSRnKXGkqL-WMpwHanqxxxGjIkFg',
    appId: '1:1086776185649:android:fa03ba348f12fe5f4bd610',
    messagingSenderId: '1086776185649',
    projectId: 'pdb-photo-project',
    storageBucket: 'pdb-photo-project.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCfvPNBDqJIJY1eWesmmoB4-R1HE-v--h0',
    appId: '1:1086776185649:ios:5170f5f3ed04fee64bd610',
    messagingSenderId: '1086776185649',
    projectId: 'pdb-photo-project',
    storageBucket: 'pdb-photo-project.appspot.com',
    androidClientId: '1086776185649-79lfa0tkq8lllrfg00u9g4j31ae7d1qf.apps.googleusercontent.com',
    iosClientId: '1086776185649-s3d78ou2silbagrgik3tiehfr684hjrf.apps.googleusercontent.com',
    iosBundleId: 'com.example.appSkeleton',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCfvPNBDqJIJY1eWesmmoB4-R1HE-v--h0',
    appId: '1:1086776185649:ios:6c2d37c597296e374bd610',
    messagingSenderId: '1086776185649',
    projectId: 'pdb-photo-project',
    storageBucket: 'pdb-photo-project.appspot.com',
    androidClientId: '1086776185649-79lfa0tkq8lllrfg00u9g4j31ae7d1qf.apps.googleusercontent.com',
    iosClientId: '1086776185649-10mevt9vc71773lno3515curitb7sj84.apps.googleusercontent.com',
    iosBundleId: 'com.example.appSkeleton.RunnerTests',
  );
}
