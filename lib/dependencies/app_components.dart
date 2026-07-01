import 'package:firebase_core/firebase_core.dart';
import 'package:lojavirtualapp/firebase_options.dart';

abstract class AppComponents {
  static Future<void> initApp() async {
    await _initFirebase();
  }
}

Future<void> _initFirebase() async => await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
