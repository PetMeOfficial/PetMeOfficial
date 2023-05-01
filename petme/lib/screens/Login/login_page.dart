import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

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
      backgroundColor: Color(0xFFF5F5DC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Center(
                child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02,
                  ),
                  child: const Text(
                    'Find Your Furry \n        Soulmate Today!',
                    style: TextStyle(
                        fontSize: 29,
                        color: Color(0xFF487776),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Center(
                child: Opacity(
                  opacity: 0.9,
                  child: Container(
                    child: Lottie.asset(
                      'assets/splash_pet.json',
                      repeat: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Center(
                child: Opacity(
                  opacity: 1,
                  child: Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.47,
                        right: 35,
                        left: 35),
                    child: Column(
                      children: [
                        TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                              hintText: 'Email id',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color(0xFF487776)
                                  ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Color(0xFF487776), // Set border color to green when the TextField is focused
                                ),
                              ),
                            // filled: true,
                            // fillColor: Color(0xFFF5F5DC),
                            fillColor: Colors.transparent

                          ),
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
                                  borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color(0xFF487776), // Set border color to green when the TextField is focused
                              ),
                            ),),

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
                                color: Colors.black,
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
                                      color: Color(0xFF487776)),
                                )) // Sign Up
                          ],
                        ),
                        const SizedBox(
                          height: 40,
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
                                    backgroundColor: Color(0xFF487776),
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
                        const SizedBox(height: 20,),
                        ElevatedButton(
                            onPressed: () {
                              // Navigator.pushNamed(context, 'forgot');
                              Get.toNamed('forgot');
                            },
                            style: ElevatedButton.styleFrom(
                              // padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 5),
                              padding: const EdgeInsets.fromLTRB(
                                  80, 10, 80, 10),
                              backgroundColor: const Color(0xFF487776),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(10.0)),
                            ),
                            child: const Text(
                              'Forgot Password',
                              style: TextStyle(
                                  fontSize: 20,
                                  // fontWeight: FontWeight.bold,
                              ),
                            )
                        ),
                        const SizedBox(height: 40,),
                      ],
                    ),
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
