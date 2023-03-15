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
      String caption,
      String username,
      String uid,
      String profilePicUrl,
      String petName,
      String petBreed,
      String petAge,
      String petGender,
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
        caption: caption,
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

  Future<List<Post>> loadPets() async {
    try {
      final petsSnapshot = await FirebaseFirestore.instance.collection('posts').get();
      return petsSnapshot.docs
          .map((doc) => Post(
        username: doc.get('username'),
        datePublished: doc.get('datePublished'),
        postUrl: doc.get('postUrl'),
        description: doc.get('description'),
        postId: doc.get('postId'),
        uid: doc.get('uid'),
        profilePicUrl: doc.get('profilePicUrl'),
        petName: doc.get('petName'),
        petBreed: doc.get('petBreed'),
        petGender: doc.get('petGender'),
        petAge: doc.get('petAge'),
        petSize: doc.get('petSize'),
        petType: doc.get('petType'),
        caption: doc.get('caption'),
        // breed: doc.get('petBreed'),
        // age: doc.get('petAge'),
        // description: doc.get('petDescription'),
        // favorites: doc.get('favorites'),
        // gender: doc.get('petGender'),
        // size: doc.get('petSize'),
        // image: doc.get('petImage'),
        // latitude: doc.get('latitude'),
        // longitude: doc.get('longitude'),
        // ownerId: doc.get('ownerId'),
        // petId: doc.get('petId'),
        // type: doc.get('petType'),
      ))
          .toList();
    } catch (e) {
      return [];
    }
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


