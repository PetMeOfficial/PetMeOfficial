import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:petme/models/posts.dart';
import 'package:petme/screens/FirebaseFunctions/storage_methods.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class FirestoreMethods{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final storageRef = FirebaseStorage.instance.ref();
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

  void sendPushMessage(String token , title, body) async {
    try{
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=AAAAuNG07C0:APA91bH2OYAf0oXU0p1PwIzdDW9fDd3RAWoZxRSRu7rDEbqeRiGd4ZH_cFjgh930Y_xMFdYaFuPU7S4HsGyU1IlgMbkoUQGV-SOZO2qVpzB2pF4XeAwB77tjHNi803Ox1eqDjwtQZ6Ck'
        },
        body: jsonEncode(
          <String, dynamic>{

            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': body,
              'title': title,
            },

            "notification" : <String, dynamic>{
              "title":title,
              "body": body,
              "android_channel_id": "petme"
            },
            "to": token,
          },
        ),
      );
    }catch (e){
      if(kDebugMode){
        print("Error Push Notification");
      }
    }
  }
}


