import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petme/models/posts.dart';
import 'package:petme/screens/FirebaseFunctions/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Upload Posts
  Future<String> uploadPost(
      Uint8List file,
      String description,
      String username,
      String uid,
      String profilePicUrl,
      String petName,
      String petBreed,
      String petGender,
      String petAge,
      String petSize,
      String petType,
      ) async {
    String res = "some error occured";
    try{
      String photoUrl = await StorageMethods().uploadImageToStorage('posts', file, true);
      String postId = const Uuid().v1();
      Post post = Post(
        datePublished: DateTime.now(),
        description: description,
        username: username,
        uid: uid,
        postUrl: photoUrl,
        postId: postId,
        profilePicUrl: profilePicUrl,
        petName: petName,
        petBreed: petBreed,
        petGender: petGender,
        petSize: petSize,
        petAge: petAge,
        petType: petType,
      );
      _firestore.collection('posts').doc(postId).set(post.toJson(),);
      res = "Success";
      debugPrint("Success");
    } catch(err){
      res = err.toString();
    }
    return res;
  }

  Future<String> deletePost(String postId) async {
    String res = "Some error occurred";
    try {
      await _firestore.collection('posts').doc(postId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}


