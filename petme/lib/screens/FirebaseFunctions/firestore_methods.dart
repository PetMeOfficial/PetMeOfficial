import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petme/models/posts.dart';
import 'package:petme/screens/FirebaseFunctions/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Upload Posts
  Future<String> uploadPost(Uint8List file) async {
    String res = "some error occured";
    try{
      final storageMethods = StorageMethods();
      String photoUrl = await storageMethods.uploadImageToStorage('posts', file, true);

      Post post = Post(
        datePublished: DateTime.now(),
        postUrl: photoUrl,
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