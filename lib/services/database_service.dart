
import 'package:assignment_project/model/blog.dart';
import 'package:assignment_project/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  //INITIALIZATION & ONUPDATE PROFILE
  Future<UserDetail> getUserData(String uid) {
    return _firestore.collection('User').doc(uid).get()
    .then((DocumentSnapshot snapshot) => UserDetail.fromMap(snapshot.data()));
  }


  //blog trending
  Stream<List<BlogTrending>> getBlogTrending() {
    return _firestore.collection('Blog-Trendings')
    .snapshots()
    .map((event) => event.docs.map((e) => BlogTrending.fromMap(e.data())).toList());
  }

  //blog cats
  Stream<List<BlogCats>> getBlogCats() {
    return _firestore.collection('Blog-Cats')
    .snapshots()
    .map((event) => event.docs.map((e) => BlogCats.fromMap(e.data())).toList());
  }

  //blog dogs
  Stream<List<BlogDogs>> getBlogDogs() {
    return _firestore.collection('Blog-Dogs')
    .snapshots()
    .map((event) => event.docs.map((e) => BlogDogs.fromMap(e.data())).toList());
  }

}