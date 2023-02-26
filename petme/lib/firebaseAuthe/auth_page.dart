import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petme/screens/HomeScreen/main_page.dart';
// import 'package:petme/firebaseAuthe/auth_page.dart';
import 'package:petme/screens/Login/login_page.dart';
import 'package:petme/screens/Registration/Pet/petSignUp.dart';
// import 'package:petme/screens/petSignUp.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          // if user logged in =>
          if(snapshot.hasData){
            return const MainPage();
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
