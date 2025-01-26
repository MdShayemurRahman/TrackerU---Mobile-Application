import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
      default:
        throw UnsupportedError('Platform not supported');
    }
  }

  static FirebaseOptions get web => FirebaseOptions(
        apiKey: _getEnv('FIREBASE_WEB_API_KEY'),
        appId: _getEnv('FIREBASE_WEB_APP_ID'),
        messagingSenderId: _getEnv('FIREBASE_WEB_MESSAGING_SENDER_ID'),
        projectId: _getEnv('FIREBASE_PROJECT_ID'),
        authDomain: _getEnv('FIREBASE_AUTH_DOMAIN'),
        storageBucket: _getEnv('FIREBASE_STORAGE_BUCKET'),
      );

  static FirebaseOptions get android => FirebaseOptions(
        apiKey: _getEnv('FIREBASE_ANDROID_API_KEY'),
        appId: _getEnv('FIREBASE_ANDROID_APP_ID'),
        messagingSenderId: _getEnv('FIREBASE_ANDROID_MESSAGING_SENDER_ID'),
        projectId: _getEnv('FIREBASE_PROJECT_ID'),
        storageBucket: _getEnv('FIREBASE_STORAGE_BUCKET'),
      );

  static FirebaseOptions get ios => FirebaseOptions(
        apiKey: _getEnv('FIREBASE_IOS_API_KEY'),
        appId: _getEnv('FIREBASE_IOS_APP_ID'),
        messagingSenderId: _getEnv('FIREBASE_IOS_MESSAGING_SENDER_ID'),
        projectId: _getEnv('FIREBASE_PROJECT_ID'),
        storageBucket: _getEnv('FIREBASE_STORAGE_BUCKET'),
        iosClientId: _getEnv('FIREBASE_IOS_CLIENT_ID'),
        iosBundleId: 'com.example.trackeru',
      );

  static FirebaseOptions get macos => FirebaseOptions(
        apiKey: _getEnv('FIREBASE_IOS_API_KEY'),
        appId: _getEnv('FIREBASE_IOS_APP_ID'),
        messagingSenderId: _getEnv('FIREBASE_IOS_MESSAGING_SENDER_ID'),
        projectId: _getEnv('FIREBASE_PROJECT_ID'),
        storageBucket: _getEnv('FIREBASE_STORAGE_BUCKET'),
        iosClientId: _getEnv('FIREBASE_IOS_CLIENT_ID'),
        iosBundleId: 'com.example.trackeru.RunnerTests',
      );

  static String _getEnv(String key) {
    // First check if the key exists in dotenv.env (runtime)
    if (dotenv.isInitialized && dotenv.env.containsKey(key)) {
      return dotenv.env[key]!;
    }

    // Fallback to compile-time environment variable
    String value = String.fromEnvironment(key, defaultValue: '');
    if (value.isEmpty) {
      print("Warning: Environment variable $key is not set.");
    }
    return value;
  }
}
