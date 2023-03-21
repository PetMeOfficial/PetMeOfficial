import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petme/screens/Registration/Adopter/adopterSignUp.dart';

import '../../../Authentication/auth_page.dart';
import '../../../utils/utils.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var authController = AuthPage.instance;
  final username = TextEditingController();
  final petname = TextEditingController();
  final category = TextEditingController();
  final breed = TextEditingController();
  final phoneNumber = TextEditingController();
  final owneremail = TextEditingController();
  final passwordController = TextEditingController();
  final ownername = TextEditingController();
  Uint8List? _image;

  final db = FirebaseFirestore.instance;

  Future signUp() async {
    final createResult =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: owneremail.text.trim(),
      password: passwordController.text.trim(),
    );
    if (createResult.user == null) {
      debugPrint("Error creating database");
    } else {
      debugPrint("User database created successful");
      await db.collection("users").add({
        'Username': username.text.trim(),
        'Pet name': petname.text.trim(),
        'Breed': breed.text.trim(),
        'Category': category.text.trim(),
        'Name': ownername.text.trim(),
        'E-mail': owneremail.text.trim(),
        'Phone-No': int.parse(phoneNumber.text.trim()),
      });

      Navigator.pushNamed(context, 'login');
    }
  }

  // disposing controllers
  @override
  void dispose() {
    owneremail.dispose();
    passwordController.dispose();
    ownername.dispose();
    username.dispose();
    phoneNumber.dispose();
    category.dispose();
    breed.dispose();
    petname.dispose();
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
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(
                  height: 240,
                  width: 45,
                ),
                TextButton(
                    onPressed: () {
                      // Navigator.pushNamed(c ontext, 'adopter');
                      Navigator.push(context, PageRouteBuilder(pageBuilder:
                          (BuildContext context, Animation<double> animation1,
                              Animation<double> animation2) {
                        return const adopterSignUp();
                      }));
                    },
                    child: const Text(
                      'Adopter',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    )), // Adopter Text
                const SizedBox(
                  //  height: 120,
                  width: 100,
                ),
                TextButton(
                    onPressed: () {
                      // Navigator.pushNamed(context, 'adopter');
                      Navigator.push(context, PageRouteBuilder(pageBuilder:
                          (BuildContext context, Animation<double> animation1,
                              Animation<double> animation2) {
                        return const SignUp();
                      }));
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                        bottom: 4, // Space between underline and text
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        color: Colors.pink[400]!,
                        width: 2.0, // Underline thickness
                      ))),
                      child: const Text(
                        "Pet",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      ),
                    )) // Pet text
              ],
            ),
            Center(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.27,
                    right: 35,
                    left: 35),
                child: Form(
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
                        height: 35,
                      ),
                      TextFormField(
                        controller: username,
                        decoration: InputDecoration(
                            label: const Text('Username'),
                            labelStyle: TextStyle(color: Colors.pink[400]),
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.pink[400],
                            ),
                            // hintText: 'Email',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide: const BorderSide(
                                  width: 2.0, color: Colors.pink),
                            )),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      TextFormField(
                        controller: petname,
                        decoration: InputDecoration(
                            label: const Text('Pet Name'),
                            labelStyle: TextStyle(color: Colors.pink[400]),
                            prefixIcon: Icon(
                              Icons.pets,
                              color: Colors.pink[400],
                            ),
                            // hintText: 'Email',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide: const BorderSide(
                                  width: 2.0, color: Colors.pink),
                            )),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      TextFormField(
                        controller: category,
                        decoration: InputDecoration(
                            label: const Text('Category'),
                            labelStyle: TextStyle(color: Colors.pink[400]),
                            prefixIcon: Icon(
                              Icons.category,
                              color: Colors.pink[400],
                            ),
                            // hintText: 'Email',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide: const BorderSide(
                                  width: 2.0, color: Colors.pink),
                            )),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      TextFormField(
                        controller: breed,
                        decoration: InputDecoration(
                            label: const Text('Breed'),
                            labelStyle: TextStyle(color: Colors.pink[400]),
                            prefixIcon: Icon(
                              Icons.catching_pokemon_outlined,
                              color: Colors.pink[400],
                            ),
                            // hintText: 'Email',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide: const BorderSide(
                                  width: 2.0, color: Colors.pink),
                            )),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      TextFormField(
                        controller: ownername,
                        decoration: InputDecoration(
                            label: const Text('Owner Name'),
                            labelStyle: TextStyle(color: Colors.pink[400]),
                            prefixIcon: Icon(
                              Icons.person_outline_rounded,
                              color: Colors.pink[400],
                            ),
                            // hintText: 'Name',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide: const BorderSide(
                                  width: 2.0, color: Colors.pink),
                            )),
                      ), // Name
                      const SizedBox(
                        height: 35,
                      ),
                      TextFormField(
                        controller: owneremail,
                        decoration: InputDecoration(
                            label: const Text('Owner Email'),
                            labelStyle: TextStyle(color: Colors.pink[400]),
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: Colors.pink[400],
                            ),
                            // hintText: 'Email',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide: const BorderSide(
                                  width: 2.0, color: Colors.pink),
                            )),
                      ), // Email
                      const SizedBox(
                        height: 35,
                      ),
                      TextFormField(
                        controller: phoneNumber,
                        decoration: InputDecoration(
                            label: const Text('Phone Number'),
                            labelStyle: TextStyle(color: Colors.pink[400]),
                            prefixIcon: Icon(
                              Icons.numbers_outlined,
                              color: Colors.pink[400],
                            ),
                            // hintText: 'Email',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide: const BorderSide(
                                  width: 2.0, color: Colors.pink),
                            )),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(
                            label: const Text('Password'),
                            labelStyle: TextStyle(color: Colors.pink[400]),
                            prefixIcon: Icon(
                              Icons.fingerprint,
                              color: Colors.pink[400],
                            ),
                            // hintText: 'Password',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide: const BorderSide(
                                  width: 2.0, color: Colors.pink),
                            )),
                      ), // Password
                      const SizedBox(
                        height: 50,
                      ),
                      GestureDetector(
                        onTap: signUp,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: (){
                                  authController.registerUserPet(
                                  username.text,
                                  petname.text,
                                  category.text,
                                  breed.text,
                                  ownername.text,
                                  owneremail.text,
                                  passwordController.text,
                                  phoneNumber.text,
                                  _image!,
                                  );
                                  Get.snackbar("Success", "Registration Complete");
                                },
                                style: ElevatedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.fromLTRB(85, 10, 85, 10),
                                  backgroundColor: Colors.pink[400],
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
                        height: 18,
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
