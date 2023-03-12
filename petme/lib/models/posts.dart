import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final DateTime datePublished;
  final String username;
  final String postUrl;
  final String description;
  final String uid;
  final String profilePicUrl;

  const Post({
    required this.datePublished,
    required this.username,
    required this.postUrl,
    required this.description,
    required this.uid,
    required this.profilePicUrl,
  });

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
        datePublished: snapshot["datePublished"],
        username: snapshot["username"],
        postUrl: snapshot['postUrl'],
        description: snapshot['description'],
        uid: snapshot['uid'],
      profilePicUrl: snapshot['profilePicUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
        "datePublished": datePublished,
        'postUrl': postUrl,
        'description': description,
        'username': username,
         'uid' : uid,
         'profilePicUrl' : profilePicUrl,
      };
}
