

import 'package:assignment_project/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:assignment_project/services/auth_service.dart';

class UserNotifier with ChangeNotifier {
  String _userUID;
  UserDetail _userData;
  bool _enable;
  String _test ='ayam';

  String get getUserUID => _userUID;
  UserDetail get getUserData => _userData;
  bool get getEnable => _enable;
  String get ayammas => _test;

  set setUserUID(String uid) {
    _userUID = uid;
    print("[UserNotifier] UID : $_userUID");
  }

  set setEnable(bool x) {
    _enable = x;
  }

  set setUserData(UserDetail data) {
    _userData = data;
    print('[UserNotifiere] Local Profile Downloaded');
  }


  // ------------------ DAN GOOGLE SIGN IN ---------------------------//
  final googleSignIn = GoogleSignIn();
  bool _isSigningIn;


  GoogleSignInProvider() {
    _isSigningIn = false;
  }

  bool get isSigningIn => _isSigningIn;

  set isSigningIn(bool isSigningIn) {
    _isSigningIn = isSigningIn;
    notifyListeners();
  }

  Future googleLogin() async {
    isSigningIn = true;

    final user = await googleSignIn.signIn();

    if (user == null) {
      isSigningIn = false;
      return;
    } else {
      final googleAuth = await user.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential)
      .then((value) {
        AuthService().usernamefx(value.user.email);
        //value.user.email;
      });

      isSigningIn = false;
    }
  }

  void logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }


  
}