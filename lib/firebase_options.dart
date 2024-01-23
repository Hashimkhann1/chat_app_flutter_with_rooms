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
    apiKey: 'AIzaSyDCLpLgjaFdEkV2CMkj0Yibp4QQnn0MGVI',
    appId: '1:487971971689:web:08892c4dd8277fb34338f8',
    messagingSenderId: '487971971689',
    projectId: 'roomchatapp-f775e',
    authDomain: 'roomchatapp-f775e.firebaseapp.com',
    storageBucket: 'roomchatapp-f775e.appspot.com',
    measurementId: 'G-2M82ZVWJ3K',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAXhfUkQQbguwT5X1DOlmrvF_YlE2IMviQ',
    appId: '1:487971971689:android:700a4afd01e9a6be4338f8',
    messagingSenderId: '487971971689',
    projectId: 'roomchatapp-f775e',
    storageBucket: 'roomchatapp-f775e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAGzadajsbJkzSlFJEncOZK20s4_WNwHg8',
    appId: '1:487971971689:ios:ba14d47cf567d79b4338f8',
    messagingSenderId: '487971971689',
    projectId: 'roomchatapp-f775e',
    storageBucket: 'roomchatapp-f775e.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );
}
