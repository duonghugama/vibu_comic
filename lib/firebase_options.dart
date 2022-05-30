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
    apiKey: 'AIzaSyCcNFxmTIO5wEameFIaQ_h2CQFBSYTD4TI',
    appId: '1:132407279569:web:ca0812d5aacdec3446eaf0',
    messagingSenderId: '132407279569',
    projectId: 'vibu-comic-86908',
    authDomain: 'vibu-comic-86908.firebaseapp.com',
    storageBucket: 'vibu-comic-86908.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD_nPixWoLeHJgD0dwvpBIhiMalyvJaTQY',
    appId: '1:132407279569:android:087de6318d58f28546eaf0',
    messagingSenderId: '132407279569',
    projectId: 'vibu-comic-86908',
    storageBucket: 'vibu-comic-86908.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCQDNZvprTWK8z3F5ldBHDeufxmzIjvJ5c',
    appId: '1:132407279569:ios:d73b0e33855dd60646eaf0',
    messagingSenderId: '132407279569',
    projectId: 'vibu-comic-86908',
    storageBucket: 'vibu-comic-86908.appspot.com',
    iosClientId: '132407279569-b86ifcvo5g4pnp6qnrhhpkvpgg4l1jjh.apps.googleusercontent.com',
    iosBundleId: 'com.example.vibuComic',
  );
}
