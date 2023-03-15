import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final DateTime datePublished;
  final String username;
  final String postUrl;
  final String description;
  final String caption;
  final String postId;
  final String uid;
  final String profilePicUrl;
  final String petName;
  final String petBreed;
  final String petGender;
  final String petAge;
  final String petSize;
  final String petType;

  const Post({
    required this.datePublished,
    required this.username,
    required this.caption,
    required this.postUrl,
    required this.description,
    required this.uid,
    required this.postId,
    required this.profilePicUrl,
    required this.petName,
    required this.petBreed,
    required this.petGender,
    required this.petAge,
    required this.petSize,
    required this.petType,
  });

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
        datePublished: snapshot["datePublished"],
        caption: snapshot["caption"],
        username: snapshot["username"],
        postUrl: snapshot['postUrl'],
        description: snapshot['description'],
        uid: snapshot['uid'],
        postId: snapshot['postId'],
        profilePicUrl: snapshot['profilePicUrl'],
        petName: snapshot['petName'],
        petBreed: snapshot['petBreed'],
        petGender: snapshot['petGender'],
        petAge: snapshot['petAge'],
        petSize: snapshot['petSize'],
        petType: snapshot['petType'],
    );
  }

  Map<String, dynamic> toJson() => {
        "datePublished": datePublished,
        'postUrl': postUrl,
        'caption': caption,
        'description': description,
        'username': username,
        'uid' : uid,
        'postId' : postId,
        'profilePicUrl' : profilePicUrl,
        'petName' : petName,
        'petBreed' : petBreed,
        'petGender' : petGender,
        'petAge' : petAge,
        'petSize' : petSize,
        'petType' : petType,
      };
}
