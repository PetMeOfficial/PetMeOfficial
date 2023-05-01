import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:petme/Authentication/auth_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Get.put(AuthPage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5DC),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'PetMe',
              style: TextStyle(
                color: Color(0xFF487776),
                fontSize: 58.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            // SizedBox(height: 30.0),
            Container(
              child: Lottie.asset(
                'assets/splash_pet.json',
                repeat: true,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 24.0),
            const Text(
              'When I needed a Hand',
              style: TextStyle(
                color: Color(0xFF487776),
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),const Text(
              'I found a Paw',
              style: TextStyle(
                color: Color(0xFF487776),
                fontSize: 38.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
