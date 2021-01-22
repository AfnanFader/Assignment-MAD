class UserID {
  final String uid;
  UserID({this.uid});
}

class UserDetail {
  String username;
  String email;
  String phone;
  String address;
  String profilePicture;
  bool isMale;
  List postDoc;
  List wishlist;

  UserDetail(
      {this.username,
      this.email,
      this.phone,
      this.address,
      this.profilePicture,
      this.isMale,
      this.postDoc,
      this.wishlist});

  UserDetail.fromMap(Map<String, dynamic> data) {
    username = data['username'];
    email = data['email'];
    phone = data['phone'];
    address = data['address'] ?? '';
    address = data['profilePicture'] ?? null;
    isMale = data['isMale'];
    postDoc = data['postDoc'] ?? [];
    wishlist = data['wishlist'] ?? [];
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'phone': phone,
      'address': address,
      'profilePicture': profilePicture,
      'isMale': isMale,
      'postDoc': postDoc,
      'wishlist': wishlist
    };
  }
}
