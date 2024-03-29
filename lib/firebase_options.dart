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
    apiKey: 'AIzaSyA1ThZ8oJxwnSw1me4rOR82EgXs491eqC0',
    appId: '1:59298860256:web:ebf9916c1e51bb84f31485',
    messagingSenderId: '59298860256',
    projectId: 'transporte-escolar-59a20',
    authDomain: 'transporte-escolar-59a20.firebaseapp.com',
    storageBucket: 'transporte-escolar-59a20.appspot.com',
    measurementId: 'G-EZH05YGKH5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDoAvLMpK_wnkhK3VzHQZrVMp-nd9wwICA',
    appId: '1:59298860256:android:cda2766c74be15f0f31485',
    messagingSenderId: '59298860256',
    projectId: 'transporte-escolar-59a20',
    storageBucket: 'transporte-escolar-59a20.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBl_i8MWO36VwdWqydYgIt2aMIlh3D0rFM',
    appId: '1:59298860256:ios:b2706da91eecb7ddf31485',
    messagingSenderId: '59298860256',
    projectId: 'transporte-escolar-59a20',
    storageBucket: 'transporte-escolar-59a20.appspot.com',
    iosBundleId: 'com.waldirdev01.transporteEscolar',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBl_i8MWO36VwdWqydYgIt2aMIlh3D0rFM',
    appId: '1:59298860256:ios:efc2a5187aa593d6f31485',
    messagingSenderId: '59298860256',
    projectId: 'transporte-escolar-59a20',
    storageBucket: 'transporte-escolar-59a20.appspot.com',
    iosBundleId: 'com.waldirdev01.transporteEscolar.RunnerTests',
  );
}
