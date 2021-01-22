import 'package:assignment_project/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //INITIALIZATION & ONUPDATE PROFILE
  Future<UserDetail> getUserData(String uid) {
    return _firestore.collection('User').doc(uid).get().then(
        (DocumentSnapshot snapshot) => UserDetail.fromMap(snapshot.data()));
  }

  Future updateUser(String uid, String email, String username, String address,
      String phone, bool isMale) async {
    return await _firestore.collection('User').doc(uid).update({
      'username': username,
      'email': email,
      'phone': phone,
      'address': address,
      'isMale': isMale
    }).then((value) {
      print('[Firestore] User Updated');
      return true;
    });
  }
}
