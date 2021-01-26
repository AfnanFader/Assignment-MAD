import 'package:cloud_firestore/cloud_firestore.dart';

class Pet {

  String uidCreator;
  String docID;

  List<dynamic> images = [];
  String petName;
  String type;
  double age;
  String location;
  String breed;
  bool vaccine;
  String cacat;
  bool gender;
  String info;

  List requestAdopt;
  List likedUsers;
  String phoneNumber;
  Timestamp dateCreated;


  Pet({
    this.uidCreator, 
    this.docID, 
    this.petName, 
    this.type, 
    this.age, 
    this.location, 
    this.breed,
    this.vaccine,
    this.cacat,
    this.gender,
    this.info,
    this.likedUsers,
    this.phoneNumber,
    this.dateCreated,
    this.requestAdopt
  });


  set setPetImages(List data) {
    images = data;
  }


  Map<String, dynamic> toMap() {
    return {
      'uidCreator' : uidCreator,

      'PetImagesLink' : images,
      'PetName' : petName,
      'TypeOfPet' : type,
      'Age' : age,
      'Location' : location,
      'Disabilities' : cacat,
      'Gender' : gender,
      'AdditionalInfo' : info,

      'requestAdopt' : requestAdopt,
      'LikedUsers' : likedUsers,
      'PhoneNumber' : phoneNumber,
      "DateCreated" : dateCreated,
    };
  }


  Pet.fromMap(Map<String, dynamic> data, String documentID) {
    uidCreator = data['uidCreator'];

    images = data['PetImagesLink'];
    petName = data['PetName'];
    type = data['TypeOfPet'];
    age = data['Age'];
    location = data['Location'];
    cacat = data['Disabilities'];
    gender = data['Gender'];
    info = data['AdditionalInfo'];

    requestAdopt = data['requestAdopt'];
    likedUsers = data['LikedUsers'];
    phoneNumber = data['PhoneNumber'];
    dateCreated = data["DateCreated"];
    docID = documentID;
  }


}
