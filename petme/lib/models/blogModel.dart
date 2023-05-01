import 'package:cloud_firestore/cloud_firestore.dart';

class Blog {
  final String title;
  final String description;
  final String content;
  final String postImage;
  final String username;
  final String profilePicUrl;
  dynamic datetime;

   Blog(
      {
        required this.title,
        required this.description,
        // required this.photoUrl,
        required this.content,
        required this.postImage,
        required this.datetime,
        required this.username,
        required this.profilePicUrl,
      });

  static Blog fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Blog(
      title: snapshot["title"],
      description: snapshot["description"],
      content: snapshot["content"],
      postImage: snapshot["postImage"],
      datetime: snapshot["datetime"],
      username: snapshot["username"],
      profilePicUrl: snapshot["profilePicUrl"],
    );
  }

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "content": content,
    "postImage": postImage,
    "datetime": datetime,
    "username": username,
    "profilePicUrl": profilePicUrl,
  };
}
