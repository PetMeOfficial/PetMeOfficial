import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({Key? key}) : super(key: key);

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
                  'Forgot Password',
                  style: TextStyle(
                      fontSize: 32,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold),
                ),
              ), // LogIn
              Container(
                padding: const EdgeInsets.only(left: 35, top: 115),
                child: const Text(
                  'We will send you a reset link',
                  style: TextStyle(fontSize: 20, color: Colors.black87),
                ),
              ), // Log in to continue
              Center(
                  child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.23,
                    right: 35,
                    left: 35),
                child: Column(children: [
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: null,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  var forgotEmail =
                                      emailController.text.trim();

                                  try {
                                    FirebaseAuth.instance
                                        .sendPasswordResetEmail(
                                            email: forgotEmail)
                                        .then((value) =>
                                            debugPrint("Email Sent"));
                                  } on FirebaseAuthException catch (e) {
                                    debugPrint("Error $e");
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.fromLTRB(50, 10, 50, 10),
                                  backgroundColor: Colors.pink[400],
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                ),
                                child: const Text(
                                  'Forgot Password',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ]
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
