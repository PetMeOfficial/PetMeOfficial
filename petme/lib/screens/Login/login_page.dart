import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyLogin extends StatefulWidget {
  MyLogin({Key? key}) : super(key: key);

  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // final user = FirebaseAuth.instance.currentUser!;

  //Sign In method
  Future signIn() async {
    debugPrint("Clicked");


      final loginResult = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
    );
      if(loginResult.user == null){
        debugPrint("Login Error");
      } else {
        debugPrint("Login Successfully done");
        Navigator.pushNamed(context, 'home');
        super.dispose();
      }


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
                      TextFormField(

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
                                Navigator.pushNamed(context, 'adopter');
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
                        onTap: signIn,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  signIn();
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.fromLTRB(
                                      130, 10, 130, 10),
                                  backgroundColor: Colors.pink[400],
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
