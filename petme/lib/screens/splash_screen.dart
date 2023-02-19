import 'dart:async';
import 'package:petme/screens/login_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MyLogin()));
    });
  }

  // const SplashScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.pink[200],
        body: Center(
          child: Container(
            child: Image.asset(
              'assets/petLogo.png',
              // child: Center(
              //   child: Text(
              //     'Pet Me',
              //     style: TextStyle(
              //         fontSize: 58,
              //         fontWeight: FontWeight.bold,
              //         color: Colors.white,
              //
              //     ),
              //   ),
              // ),
            ),
          ),
        ));
  }
}
