import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyLogin extends StatefulWidget {
   MyLogin({Key? key}) : super(key: key);

   // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Sign-In Method
  void signUserIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
    );
  }

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future signIn() async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
    );
  }

  // disposing controllers
  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(left: 35, top: 60),
                  child: Text('Log In' , style: TextStyle(fontSize: 32, color: Colors.black87, fontWeight: FontWeight.bold),),
              ),
              Container(
                padding: EdgeInsets.only(left: 35, top: 100),
                child: Text('Log in to continue' , style: TextStyle(fontSize: 20, color: Colors.black87),),
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.23,
                  right: 35, left: 35
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                            hintText: 'Email id',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                          )
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                      ),
                      SizedBox(
                        height: 28,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Don\'t have an account?',
                            style: TextStyle(
                            fontSize: 17,
                            color: Colors.grey,
                          ),
                          ),
                          TextButton(onPressed: (){
                            Navigator.pushNamed(context, 'adopter');
                          },
                              child: Text('Sign Up',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black ),
                          )
                          )
                        ],
                      ),
                      SizedBox(
                        height: 120,
                      ),
                      GestureDetector(
                        onTap: signIn,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(onPressed: (){
                              signIn();
                            },
                                child: Text(
                              'LOGIN' ,
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                              style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.fromLTRB(141, 10, 141, 10),
                            backgroundColor: Colors.pink[400],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)
                            ),
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
