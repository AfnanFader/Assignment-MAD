import 'package:assignment_project/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<UserID> get loginStream {
    return _auth.authStateChanges().map((User data) {
      if (data != null) {
        return UserID(uid: data.uid);
      } else {
        return null;
      }
    });
  }

  signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password)
      .then((UserCredential user) {
        print("[Firebase] Logging in process completed");
      });
    } catch (e) {
      print("[Firebase] Error during logging");
    }
  }

  signOut() async {
    try {
      await _auth.signOut().then((_) {
        print("[FIrebase] Succesful sign out");
      });  
    } catch (e) {
      print("[Firebase] Error during logging out $e");
    }
  }

  signUp(String email, String password) async {
      try {
        await _auth.createUserWithEmailAndPassword(email: email, password: password);
      } catch (e) {
        print("[Firestore] Failed Sign Up");
      }
  }
}