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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyBN4XJgGOPPd-PoqevStLwHfxzAuri4IPY',
    appId: '1:145689848615:web:b4d32c9a088230fa2dd702',
    messagingSenderId: '145689848615',
    projectId: 'taskly-f29f2',
    authDomain: 'taskly-f29f2.firebaseapp.com',
    storageBucket: 'taskly-f29f2.appspot.com',
    measurementId: 'G-LS65YHC8EW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyANMe-YHG7vadiE6uqIho3CfDf4YQBabzk',
    appId: '1:145689848615:android:ff1b6aa794e504742dd702',
    messagingSenderId: '145689848615',
    projectId: 'taskly-f29f2',
    storageBucket: 'taskly-f29f2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC9_QBSXy6gue8Cf5XR2K5rGpLWk7qmvIY',
    appId: '1:145689848615:ios:451afa7d10ee92432dd702',
    messagingSenderId: '145689848615',
    projectId: 'taskly-f29f2',
    storageBucket: 'taskly-f29f2.appspot.com',
    iosBundleId: 'com.example.notifytask',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC9_QBSXy6gue8Cf5XR2K5rGpLWk7qmvIY',
    appId: '1:145689848615:ios:451afa7d10ee92432dd702',
    messagingSenderId: '145689848615',
    projectId: 'taskly-f29f2',
    storageBucket: 'taskly-f29f2.appspot.com',
    iosBundleId: 'com.example.notifytask',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBN4XJgGOPPd-PoqevStLwHfxzAuri4IPY',
    appId: '1:145689848615:web:daea6b5d49ae319a2dd702',
    messagingSenderId: '145689848615',
    projectId: 'taskly-f29f2',
    authDomain: 'taskly-f29f2.firebaseapp.com',
    storageBucket: 'taskly-f29f2.appspot.com',
    measurementId: 'G-HLD4H22FBP',
  );
}
