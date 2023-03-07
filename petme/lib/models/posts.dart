import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final DateTime datePublished;
  final String username;
  final String postUrl;
  final String description;

  const Post({
    required this.datePublished,
    required this.username,
    required this.postUrl,
    required this.description,
  });

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
        datePublished: snapshot["datePublished"],
        username: snapshot["username"],
        postUrl: snapshot['postUrl'],
        description: snapshot['description'],
    );
  }

  Map<String, dynamic> toJson() => {
        "datePublished": datePublished,
        'postUrl': postUrl,
        'description': description,
        'username': username,
      };
}
