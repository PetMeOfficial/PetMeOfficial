import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petme/models/user.dart' as model;
import 'package:petme/models/blogModel.dart' as blogModel;
import 'package:petme/models/petUser.dart' as petModel;
import 'package:petme/screens/FirebaseFunctions/storage_methods.dart';
import 'package:petme/screens/HomeScreen/main_page.dart';
// import 'package:petme/firebaseAuthe/auth_page.dart';
import 'package:petme/screens/Login/login_page.dart';
// import 'package:petme/screens/petSignUp.dart';

class AuthPage extends GetxController {
  static AuthPage instance = Get.find();
  late Rx<User?> _user;
  // const AuthPage({Key? key}) : super(key: key);

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
        model.User user = model.User(
          username: username,
          name: name,
          email: email,
          password: password,
          phoneNumber: phoneNumber,
          uid: cred.user!.uid,
          profilePicUrl: profilePicUrl,
        );
        await FirebaseFirestore.instance.collection("Adopters").doc(
            cred.user!.uid).set(user.toJson());
      } else {
        Get.snackbar(
            "Error Creating An Account", "Please Enter All The Fields");
      }
    } catch (e) {
      Get.snackbar("Error Creating An Account", e.toString());
      debugPrint(e as String?);
    }
  }

  void CreateblogPost(
      String title,
      String description,
      String content,
      Uint8List file,

      ) async {
    try {
      if (
      title.isNotEmpty &&
          description.isNotEmpty &&
          content.isNotEmpty
      ) {

        String profilePicUrl = await StorageMethods().uploadImageToStorage('BlogPostImage', file, false);
        blogModel.Blog blog = blogModel.Blog(
          title: title,
          description: description,
          content: content,
          postImage: profilePicUrl,

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

  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email, password: password);
        Get.snackbar("Authentication Complete", "Signing In", colorText: Colors.greenAccent[400], backgroundColor: Colors.white);
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
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         // if user logged in =>
//         if (snapshot.hasData) {
//           return const MainPage();
//         }
//         // if user not logged in =>
//         else {
//           return MyLogin();
//         }
//       },
//     ));
//   }
// }
