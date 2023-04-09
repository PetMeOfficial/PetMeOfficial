import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Authentication/auth_page.dart';


class MyLogin extends StatefulWidget {
  MyLogin({Key? key}) : super(key: key);

  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  var authController = AuthPage.instance;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // final user = FirebaseAuth.instance.currentUser!; // Null Error Line!!!!

  //Sign In method
  Future signIn() async {
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),

    ).then((value) => super.dispose());
    }catch(_){}
  }

  // disposing controllers
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 35, top: 75),
                child: const Text(
                  'Log In',
                  style: TextStyle(
                      fontSize: 32,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold),
                ),
              ), // LogIn
              Container(
                padding: const EdgeInsets.only(left: 35, top: 115),
                child: const Text(
                  'Log in to continue',
                  style: TextStyle(fontSize: 20, color: Colors.black87),
                ),
              ), // Log in to continue
              Center(
                child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.23,
                      right: 35,
                      left: 35),
                  child: Column(
                    children: [
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                            hintText: 'Email id',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ), // Email
                      const SizedBox(
                        height: 35,
                      ),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ), // Password
                      const SizedBox(
                        height: 28,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            'Don\'t have an account?',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.grey,
                            ),
                          ), // 'Don\'t have an account?',
                          TextButton(
                              onPressed: () {
                                // Navigator.pushNamed(context, 'adopter');
                                Get.toNamed('adopter');
                              },

                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              )) // Sign Up
                        ],
                      ),
                      const SizedBox(
                        height: 120,
                      ),
                      GestureDetector(
                        onTap: () => authController.loginUser(emailController.text, passwordController.text),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  authController.loginUser(emailController.text, passwordController.text);
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.fromLTRB(
                                      130, 10, 130, 10),
                                  backgroundColor: Colors.deepPurple[400],
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                ),
                                child: const Text(
                                  'LOGIN',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 60,),
                      ElevatedButton(
                          onPressed: () {
                            // Navigator.pushNamed(context, 'forgot');
                            Get.toNamed('forgot');
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 5),
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(50.0)),
                          ),
                          child: const Text(
                            'Forgot Password',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          )
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
