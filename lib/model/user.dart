
class UserID {
  final String uid;
  UserID({this.uid});
}

class UserDetail {

  String username;
  String email;
  String phone;
  String address;
  bool isMale;
  List postDoc;
  List wishlist;

  UserDetail({
    this.username, this.email,
    this.phone, this.address, this.isMale,
    this.postDoc, this.wishlist
  });

  UserDetail.fromMap(Map<String,dynamic> data) {
    username = data['username'];
    email = data['email'];
    phone = data['phone'];
    address = data['address'];
    isMale = data['isMale'];
    postDoc = data['postDoc'];
    wishlist = data['wishlist'];
  }

  Map<String, dynamic> toMap() {
    return {
      'username' : username,
      'email' : email,
      'phone' : phone,
      'address' : address,
      'isMale' : isMale,
      'postDoc' : postDoc,
      'wishlist' : wishlist
    };
  }
}