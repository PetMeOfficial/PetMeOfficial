import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petme/screens/home_page.dart';
import 'package:petme/screens/login_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          // if user logs in =>
          if(snapshot.hasData){
            return HomePage();
          }
          // if user not logged in =>
          else{
           return MyLogin();
          }


    },
    )
    );
  }
}
