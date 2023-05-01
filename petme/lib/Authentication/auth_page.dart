import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petme/models/user.dart' as model;
import 'package:petme/models/blogModel.dart' as blogModel;
import 'package:petme/models/petUser.dart' as petModel;
import 'package:petme/screens/FirebaseFunctions/storage_methods.dart';
import 'package:petme/screens/MainScreen/main_page.dart';
import 'package:petme/screens/Login/login_page.dart';
import 'package:http/http.dart' as http;

class AuthPage extends GetxController {
  static AuthPage instance = Get.find();
  late Rx<User?> _user;

  void registerUserAdopter(
      String username,
      String name,
      String email,
      String password,
      String phoneNumber,
      Uint8List file,
      ) async {
    try {
      if (
      username.isNotEmpty &&
          name.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          phoneNumber.isNotEmpty &&
          file.isNotEmpty
      ) {
        UserCredential cred = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: email,
            password: password
        );
        String profilePicUrl = await StorageMethods().uploadImageToStorage('profilePics', file, false);
        String? MyToken = await FirebaseMessaging.instance.getToken();
        model.User user = model.User(
          username: username,
          name: name,
          email: email,
          password: password,
          phoneNumber: phoneNumber,
          uid: cred.user!.uid,
          profilePicUrl: profilePicUrl,
          token: MyToken
        );
        await FirebaseFirestore.instance.collection("Adopters").doc(
            cred.user!.uid).set(user.toJson());
        // Updating Token Below
        String? NewToken = await FirebaseMessaging.instance.getToken();
        print("New Token is $NewToken");
        isTokenRefresh();
        // Updating Token in Firestore
        final adopterRef = FirebaseFirestore.instance.collection("Adopters").
        where("email", isEqualTo: email).get().then((value) => {
          value.docs.forEach((element) async {
            var UID = element.id;
            print("Current User's UID is: $UID");
            await FirebaseFirestore.instance
                .collection("Adopters")
                .doc(UID)
                .update({
              'token': NewToken,
            })
            ;})
        });
      } else {
        Get.snackbar(
            "Error Creating An Account", "Please Enter All The Fields");
      }
    } catch (e) {
      Get.snackbar("Error Creating An Account", e.toString());
      debugPrint(e as String?);
    }
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

  void CreateblogPost(
      String title,
      String description,
      String content,
      String username,
      String profilePicUrl,
      Uint8List file,

      ) async {
    try {
      if (
      title.isNotEmpty &&
          description.isNotEmpty &&
          content.isNotEmpty
      ) {

        String postImage = await StorageMethods().uploadImageToStorage('BlogPostImage', file, false);
        blogModel.Blog blog = blogModel.Blog(
          title: title,
          description: description,
          content: content,
          postImage: postImage,
          username: username,
          profilePicUrl: profilePicUrl,
          datetime: DateTime.now().toString(),


        );
        await FirebaseFirestore.instance.collection("Blogs").doc().set(blog.toJson());
      } else {
        Get.snackbar(
            "Error Creating An Account", "Please Enter All The Fields");
      }
    } catch (e) {
      Get.snackbar("Error Creating An Account", e.toString());
      debugPrint(e as String?);
    }
  }

  void registerUserPet(String username,
      String petname,
      String category,
      String breed,
      String ownername,
      String owneremail,
      String password,
      String ownerphoneNumber,
      Uint8List file,
      ) async {
    try {
      if (
      username.isNotEmpty &&
          petname.isNotEmpty &&
          category.isNotEmpty &&
          breed.isNotEmpty &&
          ownername.isNotEmpty &&
          owneremail.isNotEmpty &&
          password.isNotEmpty &&
          ownerphoneNumber.isNotEmpty
      ) {
        UserCredential cred = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: owneremail,
            password: password
        );
        String profilePicUrl = await StorageMethods().uploadImageToStorage('profilePics', file, false);

        petModel.PetUser user = petModel.PetUser(
          username: username,
          petname: petname,
          breed: breed,
          category: category,
          ownername: ownername,
          owneremail: owneremail,
          password: password,
          ownerphoneNumber: ownerphoneNumber,
          uid: cred.user!.uid,
          profilePicUrl: profilePicUrl,
        );
        await FirebaseFirestore.instance.collection("Pets")
            .doc(cred.user!.uid)
            .set(user.toJson());
      } else {
        Get.snackbar(
            "Error Creating An Account", "Please Enter All The Fields");
      }
    } catch (e) {
      Get.snackbar("Error Creating An Account", e.toString());
      debugPrint(e as String?);
    }
  }

  void isTokenRefresh() async {
    FirebaseMessaging.instance.onTokenRefresh.listen((event) {
        event.toString();
        print("refresh");
    });
  }

  void loginUser(String email, String password) async {
    try {
      // New Token generation if necessary
      String? MyToken = await FirebaseMessaging.instance.getToken();
      print("New Token is $MyToken");
      isTokenRefresh();
      // Updating Token in Firestore
      final adopterRef = FirebaseFirestore.instance.collection("Adopters").
      where("email", isEqualTo: email).get().then((value) => {
        value.docs.forEach((element) async {
          var UID = element.id;
          print("Current User's UID is: $UID");
          await FirebaseFirestore.instance
          .collection("Adopters")
          .doc(UID)
          .update({
            'token': MyToken,
          });
        })
      });

      if (email.isNotEmpty && password.isNotEmpty) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email, password: password);
        Get.snackbar("Pawsome to See You Again!", "", colorText: Color(0xFF487776), backgroundColor: Color(0xFFF5F5DC));
      } else {
        Get.snackbar("Error Logging in", "Please Enter All The Fields");
      }
    } catch (e) {
      Get.snackbar("Error Logging In", e.toString());
      debugPrint(e.toString());
    }
  }

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(FirebaseAuth.instance.currentUser);
    _user.bindStream(FirebaseAuth.instance.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    Future.delayed(const Duration(seconds: 3), () {
      if (user == null) {
        Get.offAll(() => MyLogin());
      } else {
        Get.offAll(() => const MainPage());
      }
    });
  }
}
