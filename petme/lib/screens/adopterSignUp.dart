import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petme/screens/signuppage.dart';
import 'home_page.dart';

class adopterSignUp extends StatefulWidget {
  const adopterSignUp({super.key});

  @override
  State<adopterSignUp> createState() => _adopterSignUpState();
}

class _adopterSignUpState extends State<adopterSignUp> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  Future signUp() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    ).then((value) => Navigator.push(context,
        MaterialPageRoute(builder: (context) => HomePage())));
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
                      // Navigator.pushNamed(context, 'adopter');
                      Navigator.push(context, PageRouteBuilder(pageBuilder:
                          (BuildContext context, Animation<double> animation1,
                              Animation<double> animation2) {
                        return const adopterSignUp();
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
                        "Adopter",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
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
                    child: const Text(
                      'Pet',
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )), // Pet Text
              ],
            ),
            Center(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.27,
                    right: 35,
                    left: 35),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                          hintText: 'Name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13))),
                    ), // Name
                    const SizedBox(
                      height: 35,
                    ),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          hintText: 'Email id',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13))),
                    ), // Email
                    const SizedBox(
                      height: 35,
                    ),
                    TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13))),
                    ), // Password
                    const SizedBox(
                      height: 35,
                    ),
                    // TextField(
                    //   obscureText: true,
                    //   decoration: InputDecoration(
                    //       hintText: 'Re-Enter Password',
                    //       border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(13))),
                    // ),
                    // const SizedBox(
                    //   height: 48,
                    // ),
                    GestureDetector(
                      onTap: signUp,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                signUp();
                              },
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.fromLTRB(85, 10, 85, 10),
                                backgroundColor: Colors.pink[400],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                              ),
                              child: const Text(
                                'Create Account',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
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
                          ElevatedButton(
                              onPressed: () {
                                // Navigator.pushNamed(context, 'login');
                                Navigator.push(context, PageRouteBuilder(
                                    pageBuilder: (BuildContext context,
                                        Animation<double> animation1,
                                        Animation<double> animation2) {
                                  return const SignUp();
                                }));
                              },
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                backgroundColor: Colors.black87,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                              ),
                              child: const Text(
                                'Go To Pet',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )) // go to pet
                        ],
                      ),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
