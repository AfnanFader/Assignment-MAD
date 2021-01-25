import 'dart:io';
import 'dart:typed_data';
import 'package:assignment_project/model/blog.dart';
import 'package:assignment_project/model/pet.dart';
import 'package:assignment_project/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';
import 'package:assignment_project/notifier/UserNotifier.dart';
import 'package:random_string/random_string.dart';

class DatabaseService {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference petPostsCollectionRef = FirebaseFirestore.instance.collection('PetPosts');


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
  //pet post
  Stream<List<Pet>> getPetPost(String uidCreator) {
    return _firestore.collection('PetPosts').where('uidCreator', isEqualTo: uidCreator).snapshots().map((event) =>
        event.docs.map((e) => Pet.fromMap(e.data(), e.id)).toList());
  }

  Stream<List<Pet>> getPetLiked(String uidCreator) {
    return _firestore.collection('PetPosts').where('LikedUsers', arrayContains: uidCreator).snapshots().map((event) =>
        event.docs.map((e) => Pet.fromMap(e.data(), e.id)).toList());
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


    //Firebase Storage for Posts
  Future<List<String>> uploadPetImage(List<Asset> asset, String creatorUID, String petname) async {

    List<String> uploadUrl = [];

    await Future.wait(
        asset.map((Asset image) async {

          String fileName = petname + randomAlphaNumeric(6); //name of file

          ByteData byteData = await image.getByteData(quality: 100);
          List<int> imageData = byteData.buffer.asUint8List();

          StorageTaskSnapshot snapshot = await FirebaseStorage.instance.ref().child('/petPostImages/$creatorUID/$fileName')
          .putData(imageData).onComplete;
          
          if (snapshot.error == null) {
            String downloadUrl = await snapshot.ref.getDownloadURL();
            uploadUrl.add(downloadUrl);
            print('[Pet Post] Storage Success upload');
          } else {
            print('[Pet Post] Storage Error during upload : ${snapshot.error.toString()}');
            throw ('something wrong here boi');
          }
        }),
        eagerError: true,
        cleanUp: (_) {
          print('[Pet Post] Storage CleanUp Error');
        });
    return uploadUrl;
  }


  //Submit Post Pets
  Future<bool> submitNewPetPost(Pet petData, UserNotifier userNotifier, List<Asset> asset) async {

    try {
      return Future.wait([uploadPetImage(asset, userNotifier.getUserUID, petData.petName)]).then((value) async {

        petData.setPetImages = value[0];
        return petPostsCollectionRef.add(petData.toMap()).then((doc) {        
          print("[Pet Post] Succesfully upload Pet documents");
          return true;
        });
      });
    } catch (e) {
      print("[Pet Post] Error in create Pet Post function : ${e.toString()}");
      return false;
    }
  }


}
