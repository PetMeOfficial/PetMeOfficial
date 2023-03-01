import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final DateTime datePublished;
  final String postUrl;

  const Post({
    required this.datePublished,
    required this.postUrl,
  });

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
        datePublished: snapshot["datePublished"],
        postUrl: snapshot['postUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
        "datePublished": datePublished,
        'postUrl': postUrl,
      };
}
