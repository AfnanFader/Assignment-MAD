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

}