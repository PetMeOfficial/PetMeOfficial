import 'package:cloud_firestore/cloud_firestore.dart';

class Blog {
  final String username;
  final String blogUrl;
  final String description;
  final String blogId;
  final String uid;
  final String profilePicUrl;
  final String blogName;
  final String blogTitle;
  final String blogDescription;

  const Blog({
    required this.username,
    required this.blogUrl,
    required this.description,
    required this.uid,
    required this.blogId,
    required this.profilePicUrl,
    required this.blogName,
    required this.blogTitle,
    required this.blogDescription,
  });

  static Blog fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Blog(
      username: snapshot["username"],
      blogUrl: snapshot['blogUrl'],
      description: snapshot['description'],
      uid: snapshot['uid'],
      blogId: snapshot['blogId'],
      profilePicUrl: snapshot['profilePicUrl'],
      blogName: snapshot['blogName'],
      blogTitle: snapshot['blogTitle'],
      blogDescription: snapshot['blogDescription'],
    );
  }

  Map<String, dynamic> toJson() => {
    'postUrl': blogUrl,
    'description': description,
    'username': username,
    'uid' : uid,
    'postId' : blogId,
    'profilePicUrl' : profilePicUrl,
    'blogName' : blogName,
    'blogTitle' : blogTitle,
    'blogDescription' : blogDescription,
  };
}
