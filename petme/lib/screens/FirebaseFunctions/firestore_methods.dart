import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petme/models/posts.dart';
import 'package:petme/screens/FirebaseFunctions/storage_methods.dart';

class FirestoreMethods{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Upload Posts
  Future<String> uploadPost(Uint8List file, String description, String username, String uid, String profilePicUrl) async {
    String res = "some error occured";
    try{
      String photoUrl = await StorageMethods().uploadImageToStorage('posts', file, true);

      Post post = Post(
        datePublished: DateTime.now(),
        description: description,
        username: username,
        uid: uid,
        postUrl: photoUrl,
        profilePicUrl: profilePicUrl,
      );
      _firestore.collection('posts').doc().set(post.toJson(),);
      res = "Success";
      debugPrint("Success");
    } catch(err){
      res = err.toString();
    }
    return res;
  }
}