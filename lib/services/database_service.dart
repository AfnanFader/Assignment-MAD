import 'dart:io';
import 'package:assignment_project/model/blog.dart';
import 'package:assignment_project/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:assignment_project/notifier/UserNotifier.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //INITIALIZATION & ONUPDATE PROFILE
  Future<UserDetail> getUserData(String uid) {
    return _firestore.collection('User').doc(uid).get().then(
        (DocumentSnapshot snapshot) => UserDetail.fromMap(snapshot.data()));
  }

  Future updateUser(context, String uid, String email, String username,
      String address, String phone, bool isMale) async {
    return await _firestore.collection('User').doc(uid).update({
      'username': username,
      'email': email,
      'phone': phone,
      'address': address,
      'isMale': isMale
    }).then((value) {
      UserNotifier notifier = Provider.of<UserNotifier>(context, listen: false);
      DatabaseService()
          .getUserData(notifier.getUserUID)
          .then((user) => notifier.setUserData = user);
      print('[Firestore] User Updated');
      return true;
    });
  }

  Future<void> uploadProfilePicture(File profilePicture, UserNotifier userNotifier) async {
    String profileUrl;
    StorageTaskSnapshot snapshot = await FirebaseStorage.instance
        .ref()
        .child('/userProfilePicture/' + userNotifier.getUserUID)
        .putFile(profilePicture)
        .onComplete;

    if (snapshot.error == null) {
      profileUrl = await snapshot.ref.getDownloadURL();
      print('[User Profile Picture] Storage Success upload');

       await _firestore.collection('User').doc(userNotifier.getUserUID).update({
          'profilePicture': profileUrl
        }).then((value) {
          this.getUserData(userNotifier.getUserUID).then((user) => userNotifier.setUserData = user);
          print('[Firestore] User Profile Picture Updated');
        });
    } else {
      print(
          '[User Profile Picture] Storage Error during upload : ${snapshot.error.toString()}');
      throw ('something wrong here boi');
    }

  }

  //blog trending
  Stream<List<BlogTrending>> getBlogTrending() {
    return _firestore.collection('Blog-Trendings').snapshots().map((event) =>
        event.docs.map((e) => BlogTrending.fromMap(e.data())).toList());
  }

  //blog cats
  Stream<List<BlogCats>> getBlogCats() {
    return _firestore.collection('Blog-Cats').snapshots().map(
        (event) => event.docs.map((e) => BlogCats.fromMap(e.data())).toList());
  }

  //blog dogs
  Stream<List<BlogDogs>> getBlogDogs() {
    return _firestore.collection('Blog-Dogs').snapshots().map(
        (event) => event.docs.map((e) => BlogDogs.fromMap(e.data())).toList());
  }
}
