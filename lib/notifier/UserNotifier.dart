

import 'package:assignment_project/model/user.dart';
import 'package:flutter/cupertino.dart';

class UserNotifier with ChangeNotifier {
  String _userUID;
  UserDetail _userData;

  String get getUserUID => _userUID;
  UserDetail get getUserData => _userData;

  set setUserUID(String uid) {
    _userUID = uid;
    print("[UserNotifier] UID : $_userUID");
  }

  set setUserData(UserDetail data) {
    _userData = data;
    print('[UserNotifiere] Local Profile Downloaded');
  }
}