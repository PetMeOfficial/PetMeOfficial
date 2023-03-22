import 'package:cloud_firestore/cloud_firestore.dart';

class Meetings {
  final String petOwnerId;
  final String adopterId;
  final String ownerName;
  final String adopterName;
  final String location;
  final dynamic date;



  const Meetings(
      {
        required this.petOwnerId,
        required this.adopterId,
        required this.ownerName,
        required this.adopterName,
        required this.location,
        required this.date,

      });

  static Meetings fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Meetings(
      petOwnerId: snapshot["petOwnerId"],
      adopterId: snapshot["adopterId"],
      ownerName: snapshot["ownerName"],
      adopterName: snapshot["adopterName"],
      location: snapshot["location"],
      date: snapshot["date"],
      // photoUrl: snapshot["photoUrl"],


    );
  }

  Map<String, dynamic> toJson() => {
    "petOwnerId": petOwnerId,
    "adopterId": adopterId,
    "ownerName": ownerName,
    "adopterName": adopterName,
    "location": location,
    "date": date,

    // "photoUrl": photoUrl,
  };
}
