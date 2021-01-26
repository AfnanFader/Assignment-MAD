import 'package:assignment_project/model/user.dart';
import 'package:assignment_project/notifier/UserNotifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';



class AuthService {

  AuthResultStatus _status;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _database = FirebaseFirestore.instance;
  final GoogleSignIn _googleAuth = GoogleSignIn();

  Stream<UserID> get loginStream {
    return _auth.authStateChanges().map((User data) {
      if (data != null) {
        return UserID(uid: data.uid);
      } else {
        return null;
      }
    });
  }

  signIn(String email, String password, UserNotifier notifier) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password)
      .then((result) {
        notifier.setGoogleSignIn = false;
        print("[FirebaseAuth] Logging in process completed");
        if (result != null) {
          _status = AuthResultStatus.successful;
        } else {
          _status = AuthResultStatus.undefined;
        }
      });
    } catch (e) {
      print("[FirebaseAuth] Error during logging: code(${e.code}) $e");
      _status = AuthExceptionHandler.handleException(e);
    }
  return _status;
  }

  signOut(bool isGoogleSignIn) async {
    try {
      if (isGoogleSignIn) {
      await _googleAuth.disconnect().then((_) async {
        await _auth.signOut().then((_) {
          print('[FirebaseAuth] Succesful sign out');
        });
      });
      } else {
        await _auth.signOut().then((_) {
          print("[FirebaseAuth] Succesful sign out");
        });
      }  
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
      print("[FirebaseAuth] Failed Sign Up : ${e.toString()}");
      return false;
    }
  }

  Future<bool> googleAuthentication(UserNotifier notifier) async {
    try {
      return await _googleAuth.signIn().then((userAcc) async {
        if (userAcc == null) {
          print('[GoogleAuth] No user selected');
          notifier.setGoogleSignIn = false;
          return false;
        } else {
          return await userAcc.authentication.then((user) async {
            OAuthCredential credential = GoogleAuthProvider.credential(
              accessToken: user.accessToken,
              idToken: user.idToken,
            );
            return await _auth.signInWithCredential(credential).then((userData) async {
              return await _database.collection('User').doc(userData.user.uid).get().then((snapshot) async {
                if (snapshot.exists) {
                  notifier.setGoogleSignIn = true;
                  return true;
                } else {
                  UserDetail usertemp = UserDetail(
                    phone: userData.user.phoneNumber,
                    email: userData.user.email,
                    username: userData.user.displayName,
                    isMale: true
                  );
                  return await _database.collection('User').doc(userData.user.uid).set(usertemp.toMap()).then((_) {
                    notifier.setGoogleSignIn = true;
                    return true;
                  });
                }
              });
            });
          });
        }
      });
    } catch (e) {
      print('[GoogleAuth] Failed Authentication : ${e.toString()}');
      notifier.setGoogleSignIn = false;
      return false;
    }
  }
}



enum AuthResultStatus {
  successful,
  emailAlreadyExists,
  wrongPassword,
  invalidEmail,
  userNotFound,
  userDisabled,
  operationNotAllowed,
  tooManyRequests,
  undefined,
}


class AuthExceptionHandler {
  static handleException(e) {
    print(e.code);
    var status;
    switch (e.code) {
      case "wrong-password":
        status = AuthResultStatus.wrongPassword;
        break;
      case "user-not-found":
        status = AuthResultStatus.userNotFound;
        break;
      default:
        status = AuthResultStatus.undefined;
    }
    return status;
  }

  static generateExceptionMessage(exceptionCode) {
    String errorMessage;
    switch (exceptionCode) {
      case AuthResultStatus.wrongPassword:
        errorMessage = "Your login credentials are invalid.";
        break;
      case AuthResultStatus.userNotFound:
        errorMessage = "User with this email doesn't exist.";
        break;
      default:
        //errorMessage = "Undefined Error during sign in.";
        errorMessage = '$exceptionCode';
    }

    return errorMessage;
  }
}



