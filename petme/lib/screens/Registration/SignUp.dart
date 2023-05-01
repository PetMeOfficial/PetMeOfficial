import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petme/Authentication/auth_page.dart';
import 'package:get/get.dart';

import '../../utils/utils.dart';

class AdopterSignUp extends StatefulWidget {
  const AdopterSignUp({super.key});

  @override
  State<AdopterSignUp> createState() => _AdopterSignUpState();
}

class _AdopterSignUpState extends State<AdopterSignUp> {
  var authController = AuthPage.instance;
  final usernameController = TextEditingController();
  final phoneNumber = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final _form = GlobalKey<FormState>();
  Uint8List? _image;

  final db = FirebaseFirestore.instance;

  Future signUp() async {
    final createResult = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
    if(createResult.user == null){
      debugPrint("Error creating database");
    }
    else{
      debugPrint("User database created successful");

      /// below code commented just for optimizing
      // await db.collection("Adopters").add({
      //   'user namee':username.text.trim(),
      //   'Name': nameController.text.trim(),
      //   'E-mail': emailController.text.trim(),
      //   'Phone-No': int.parse(phoneNumber.text.trim()),
      // });

      Navigator.pushNamed(context, 'login');

    }
  }

  // disposing controllers
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    nameController.dispose();
    phoneNumber.dispose();
    super.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5DC),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.08,
                  right: 35,
                  left: 35),
              child: const Text(
                'Welcome to PetMe!',
                style: TextStyle(
                    fontSize: 35,
                    color: Color(0xFF487776),
                    fontWeight: FontWeight.bold),
              ),
            ),
            // Center(
            //   child: Row(
            //     // mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     children: [
            //       const SizedBox(
            //         height: 240,
            //         width: 45,
            //       ),
            //       TextButton(
            //           onPressed: () {
            //             // Navigator.pushNamed(context, 'adopter');
            //             Navigator.push(context, PageRouteBuilder(pageBuilder:
            //                 (BuildContext context, Animation<double> animation1,
            //                 Animation<double> animation2) {
            //               return const adopterSignUp();
            //             }));
            //           },
            //           child: Container(
            //             padding: const EdgeInsets.only(
            //               bottom: 4, // Space between underline and text
            //             ),
            //             decoration: BoxDecoration(
            //                 border: Border(
            //                     bottom: BorderSide(
            //                       color: Color(0xFF487776)!,
            //                       width: 2.0, // Underline thickness
            //                     ))),
            //             child: const Text(
            //               "Adopter",
            //               style: TextStyle(
            //                 color: Colors.black,
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: 32,
            //               ),
            //             ),
            //           )), // Adopter Text
            //       const SizedBox(
            //         //  height: 120,
            //         width: 100,
            //       ),
            //        // Pet Text
            //     ],
            //   ),
            // ),
            Center(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.15,
                    right: 35,
                    left: 35),
                child: Form(
                  key: _form,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          _image != null
                              ? CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(_image!),
                            backgroundColor: Colors.red,
                          )
                              : const CircleAvatar(
                            radius: 64,
                            backgroundImage: AssetImage('assets/no_profile.png'),
                            backgroundColor: Colors.red,
                          ),
                          Positioned(
                            bottom: -10,
                            left: 80,
                            child: IconButton(
                              onPressed: selectImage,
                              icon: const Icon(Icons.add_a_photo),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        controller: usernameController,
                        decoration: InputDecoration(
                            label: const Text('Username'),
                            labelStyle: const TextStyle(color: Color(0xFF487776)),
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Color(0xFF487776),
                            ),
                            // hintText: 'User Name',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide: const BorderSide(
                                  width: 2.0, color: Color(0xFF487776)),
                            )),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                            label: const Text('Name'),
                            labelStyle: const TextStyle(color: Color(0xFF487776)),
                            prefixIcon: const Icon(
                              Icons.person_2_outlined,
                              color: Color(0xFF487776),
                            ),
                            // hintText: 'Name',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide: const BorderSide(
                                  width: 2.0, color: Color(0xFF487776)),
                            )),
                      ), // Name
                      const SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                            label: const Text('Email'),
                            labelStyle: const TextStyle(color: Color(0xFF487776)),
                            prefixIcon: const Icon(
                              Icons.email_outlined,
                              color: Color(0xFF487776),
                            ),
                            // hintText: 'Email',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide: const BorderSide(
                                  width: 2.0, color: Color(0xFF487776)),
                            )),
                      ), // Email
                      const SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        controller: phoneNumber,
                        decoration: InputDecoration(
                            label: const Text('Phone Number'),
                            labelStyle: const TextStyle(color: Color(0xFF487776)),
                            prefixIcon: const Icon(
                              Icons.numbers_outlined,
                              color: Color(0xFF487776),
                            ),
                            // hintText: 'Email',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide: const BorderSide(
                                  width: 2.0, color: Color(0xFF487776)),
                            )),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(
                            label: const Text('Password'),
                            labelStyle: const TextStyle(color: Color(0xFF487776)),
                            prefixIcon: const Icon(
                              Icons.fingerprint,
                              color: Color(0xFF487776),
                            ),
                            // hintText: 'Password',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide: const BorderSide(
                                  width: 2.0, color: Color(0xFF487776)),
                            )
                        ),
                      ), // Password
                      const SizedBox(
                        height: 40,
                      ),
                      GestureDetector(
                        onTap: () => authController.registerUserAdopter(
                            usernameController.text,
                            nameController.text,
                            emailController.text,
                            passwordController.text,
                            phoneNumber.text,
                            _image!,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: (){
                                  authController.registerUserAdopter(
                                      usernameController.text,
                                      nameController.text,
                                      emailController.text,
                                      passwordController.text,
                                      phoneNumber.text,
                                    _image!,
                                  );
                                  Get.snackbar("Success", "Registration Complete");
                                },
                                //     () {
                                //   var uname = usernameController.text.trim();
                                //   var ownerN = nameController.text.trim();
                                //   var ownerE = emailController.text.trim();
                                //   var phoneN = phoneNumber.text.trim();
                                //   signUp().then((value) => db.collection("Adopters")
                                //       .doc('Data')
                                //       .set({
                                //     'Username': uname,
                                //     'Name': ownerN,
                                //     'E-mail': ownerE,
                                //     'Phone-No': int.parse(phoneN),
                                //   })
                                //   )
                                //   ;
                                // },

                                style: ElevatedButton.styleFrom(
                                  padding:
                                  const EdgeInsets.fromLTRB(85, 10, 85, 10),
                                  backgroundColor: const Color(0xFF487776),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(10.0)),
                                ),
                                child: const Text(
                                  'Create Account',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account?',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.grey,
                            ),
                          ), // 'Don\'t have an account?',
                          TextButton(
                              onPressed: () {
                                Get.toNamed('login');
                              },
                              child: const Text(
                                'Log In',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}