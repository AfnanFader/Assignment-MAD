

import 'package:assignment_project/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:assignment_project/services/auth_service.dart';

class UserNotifier with ChangeNotifier {
  String _userUID;
  UserDetail _userData;
  bool _enable;
  bool _googleSignIn;
  String _test ='ayam';

  String get getUserUID => _userUID;
  UserDetail get getUserData => _userData;
  bool get getEnable => _enable;
  String get ayammas => _test;
  bool get getGoogleSignIn => _googleSignIn;

  set setUserUID(String uid) {
    _userUID = uid;
    print("[UserNotifier] UID : $_userUID");
  }

  set setGoogleSignIn(bool status) {
    _googleSignIn = status;
    if (status) {
      print('[UserNotifier] Google Sign In Enabled');
    } else {
      print('[UserNotifier] Google Sign In Disabled');
    }
  }

  set setEnable(bool x) {
    _enable = x;
  }

  set setUserData(UserDetail data) {
    _userData = data;
    print('[UserNotifiere] Local Profile Downloaded');
  }

}