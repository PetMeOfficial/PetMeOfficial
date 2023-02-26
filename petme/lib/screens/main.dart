import 'package:flutter/material.dart';
import 'package:petme/screens/Registration/Adopter/adopterSignUp.dart';
import 'package:petme/screens/Login/login_page.dart';
import 'package:petme/screens/Registration/Pet/petSignUp.dart';
import 'package:petme/screens/SplashScreen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'splash',
    routes: {
      'login': (context) => MyLogin(),
      'signup': (context) => SignUp(),
      'splash': (context) => SplashScreen(),
      'adopter': (context) => adopterSignUp(),
    },
  ));
}
