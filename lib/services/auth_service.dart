import 'package:assignment_project/model/user.dart';
import 'package:assignment_project/notifier/UserNotifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';



class AuthService {

  final GoogleSignIn _googleAuth = GoogleSignIn();
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

  signIn(String email, String password, UserNotifier notifier) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password)
      .then((UserCredential user) {
        notifier.setGoogleSignIn = false;
        print("[FirebaseAuth] Logging in process completed");
      });
    } catch (e) {
      print("[FirebaseAuth] Error during logging");
    }
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

  
usernamefx(String email, String uid) async {
  try {

    Query q = FirebaseFirestore.instance.collection("User").where('email', isEqualTo: email);

    q.get().then((value) async{
      if(value.docs.isEmpty){
        print('email not existed');
        await _database.collection('User').doc(uid).set({
          'email': email,
          'address' : "",
          'isMale' : true,
          'phone' : "",
          'postDoc' : null,
          'username' : email,
          'wishlist' : null,
        });

        //subscribe to notifier

      } else {
        print('email existed already');
        //subscribe to notifier
      }
    } 
    );
      
  } catch (e) {
    print("[FirebaseAuth] Error usernamefx $e");
  }
}


}



