

import 'package:assignment_project/model/user.dart';
import 'package:flutter/cupertino.dart';

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
}