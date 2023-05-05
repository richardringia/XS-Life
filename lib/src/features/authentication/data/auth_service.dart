import 'package:firebase_auth/firebase_auth.dart';
class AuthService {
  static bool loggedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }
}
