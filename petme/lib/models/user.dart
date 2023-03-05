import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String username;
  final String name;
  final String email;
  final String password;
  final String phoneNumber;
  final String uid;

  const User(
      {required this.username,
        required this.name,
        // required this.photoUrl,
        required this.email,
        required this.password,
        required this.phoneNumber,
        required this.uid,
        });

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapshot["username"],
      name: snapshot["name"],
      email: snapshot["email"],
      password: snapshot["password"],
      phoneNumber: snapshot["phoneNumber"],
      // photoUrl: snapshot["photoUrl"],
      uid: snapshot["uid"],

    );
  }

  Map<String, dynamic> toJson() => {
    "username": username,
    "name": name,
    "email": email,
    "password": password,
    "phoneNumber": phoneNumber,
    "uid": uid,
    // "photoUrl": photoUrl,
  };
}
