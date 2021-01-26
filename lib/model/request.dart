class Request {
  String requestID;
  String uidCreator;
  String postUID;

  String username;
  String userUID;
  String profilePic;
  String phoneNumber;
  String status;

  String petName;
  String petImage;

  Request({
    this.uidCreator, this.postUID,
    this.username, this.profilePic,
    this.phoneNumber, this.status,
    this.petImage, this.petName,
    this.userUID
  });

  Map<String, dynamic> toMap() {
    return {
      'uidCreator' : uidCreator,
      'postUID' : postUID,
      'username' : username,
      'profilePic' : profilePic,
      'phoneNumber' : phoneNumber,
      'status' : status,
      'petName' : petName,
      'petImage' : petImage,
      'userUID' : userUID
    };
  }

  Request.fromMap(Map<String, dynamic> data, String docID) {
    uidCreator = data['uidCreator'];
    postUID = data['postUID'];

    username = data['username'];
    userUID = data['userUID'];
    profilePic = data['profilePic'];
    phoneNumber = data['phoneNumber'];
    status = data['status'];
    petName = data['petName'];
    petImage = data['petImage'];
    requestID = docID; 
  }

}