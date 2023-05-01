import 'package:cloud_firestore/cloud_firestore.dart';

class PetUser {
  final String username;
  final String petname;
  final String category;
  final String breed;
  final String ownername;
  final String owneremail;
  final String ownerphoneNumber;
  final String password;
  final String uid;
  final String profilePicUrl;

  const PetUser(
      {
        required this.username,
        required this.petname,
        required this.category,
        required this.breed,
        required this.ownername,
        required this.owneremail,
        required this.ownerphoneNumber,
        required this.password,
        required this.uid,
        required this.profilePicUrl,
      }
      );

  static PetUser fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return PetUser(
      username: snapshot["username"],
      petname: snapshot["petname"],
      category: snapshot["category"],
      breed: snapshot["breed"],
      ownername: snapshot["ownername"],
      owneremail: snapshot["owneremail"],
      ownerphoneNumber: snapshot["ownerphoneNumber"],
      password: snapshot["password"],
      uid: snapshot["uid"],
      profilePicUrl: snapshot["profilePicUrl"],

    );
  }

  Map<String, dynamic> toJson() => {
    "username": username,
    "petname": petname,
    "category": category,
    "breed": breed,
    "ownername": ownername,
    "owneremail": owneremail,
    "ownerphoneNumber": ownerphoneNumber,
    "password": password,
    "uid": uid,
    "profilePicUrl": profilePicUrl,
  };
}
