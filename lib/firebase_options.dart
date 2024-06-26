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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAXahqyWcMMEDplsBFYDTx0jEQjlW_fEFA',
    appId: '1:294794957668:android:6776e234b14667e03da071',
    messagingSenderId: '294794957668',
    projectId: 'abshar-todo-task',
    storageBucket: 'abshar-todo-task.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBaDrNAokQsW_OcSZGe4HoxTLGfI0wDhlg',
    appId: '1:294794957668:ios:48003ded27b0d8a03da071',
    messagingSenderId: '294794957668',
    projectId: 'abshar-todo-task',
    storageBucket: 'abshar-todo-task.appspot.com',
    androidClientId: '294794957668-68m3qk3vo85g4d3rb47p35i2c2d6cbia.apps.googleusercontent.com',
    iosClientId: '294794957668-lt1eolt73g4vntjgj4mkgjl3rt1e5h8q.apps.googleusercontent.com',
    iosBundleId: 'com.abshar.todo',
  );
}
