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
    apiKey: 'AIzaSyAnZHbQp1LJ5z47agQdhabQ-nB1niMcc9o',
    appId: '1:724798238129:web:8aefbae321c36a03066190',
    messagingSenderId: '724798238129',
    projectId: 'firechat-716b8',
    authDomain: 'firechat-716b8.firebaseapp.com',
    storageBucket: 'firechat-716b8.appspot.com',
    measurementId: 'G-64J2407MV3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCQwpWZPYUUx_7ZgrsMf3dE2hj7v4W5V3A',
    appId: '1:724798238129:android:08b79bb2720a4d9f066190',
    messagingSenderId: '724798238129',
    projectId: 'firechat-716b8',
    storageBucket: 'firechat-716b8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBrejXAIx0g5COC2lf13U2PkrTkkeRQbDU',
    appId: '1:724798238129:ios:83837acc16352048066190',
    messagingSenderId: '724798238129',
    projectId: 'firechat-716b8',
    storageBucket: 'firechat-716b8.appspot.com',
    iosClientId: '724798238129-m82rp686t242qk07mon6df3rhnkrv73k.apps.googleusercontent.com',
    iosBundleId: 'com.example.firechat',
  );
}
