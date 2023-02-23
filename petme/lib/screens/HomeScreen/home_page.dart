import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:petme/screens/HomeScreen/Navigation/chat_page.dart';
import 'package:petme/screens/HomeScreen/Navigation/settings_page.dart';

import 'Navigation/pet_page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  // List pages = [
  //   PetPage(),
  //   ChatPage(),
  //   SettingsPage(),
  // ];


  final user = FirebaseAuth.instance.currentUser!;

  //sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: signUserOut,
              icon: const Icon(Icons.logout
              )
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Logged In As:\n${user.email!}',
              style: const TextStyle(fontSize: 25),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const GNav(
        gap: 20,
        tabs: [
          GButton(
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            icon: Icons.pets_outlined,
            text: 'Pet',
          ),
          GButton(
              icon: Icons.search,
              text: 'Search',
          ),
          GButton(
              icon: Icons.settings,
            text: 'Settings',
          ),
        ],
      ),
    );
  }
}
