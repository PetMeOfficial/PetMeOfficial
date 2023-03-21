import 'package:cloud_firestore/cloud_firestore.dart';

class Blog {
  final String title;
  final String description;
  final String content;
  final String postImage;
  // final String password;

  const Blog(
      {
        required this.title,
        required this.description,
        // required this.photoUrl,
        required this.content,
        required this.postImage,
        // required this.password,

      });

  static Blog fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Blog(
      title: snapshot["title"],
      description: snapshot["description"],
      content: snapshot["content"],
      postImage: snapshot["postImage"],
      // password: snapshot["password"],
      // phoneNumber: snapshot["phoneNumber"],

    );
  }

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "content": content,
    "postImage": postImage,
    // "password": password,

  };
}
