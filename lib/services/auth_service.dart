import 'package:assignment_project/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _database = FirebaseFirestore.instance;

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
        print("[FirebaseAuth] Logging in process completed");
      });
    } catch (e) {
      print("[FirebaseAuth] Error during logging");
    }
  }

  signOut() async {
    try {
      await _auth.signOut().then((_) {
        print("[FirebaseAuth] Succesful sign out");
      });  
    } catch (e) {
      print("[FirebaseAuth] Error during logging out $e");
    }
  }

  Future<bool> signUp(String email, String password, UserDetail data) async {
      try {
        return await _auth.createUserWithEmailAndPassword(email: email, password: password).then((uid) async {
          return await _database.collection('User').doc(uid.user.uid).set(data.toMap()).then((value) {
            print('[Firestore] User Registered');
            return true;
          });
        });
      } catch (e) {
        print("[FirebaseAuth] Failed Sign Up");
        return false;
      }
  }
}