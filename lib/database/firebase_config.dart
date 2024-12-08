import 'package:firebase_core/firebase_core.dart';

class FirebaseConfig {
  static Future<void> initialize() async {
    try {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyDLmbKqojEafe_PWyduCvwvtnVhH5rfgIo",
          authDomain: "just-cook-it-47a29.firebaseapp.com",
          projectId: "just-cook-it-47a29",
          storageBucket: "just-cook-it-47a29.firebasestorage.app",
          messagingSenderId: "314391866357",
          appId: "1:314391866357:web:0abe293eeaa08e072dcebc",
          measurementId: "G-D4SV38GP13",
        ),
      );
    } catch (e) {
      print('Cannot connect to Firebase: $e');
    }
  }
}
