import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:petme/screens/HomeScreen/Navigation/chat_page.dart';
import 'package:petme/screens/HomeScreen/Navigation/home_page.dart';
import 'package:petme/screens/HomeScreen/Navigation/settings_page.dart';
import 'package:petme/screens/HomeScreen/Navigation/add_post_screen.dart';

import 'Navigation/pet_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    PetPage(),
    AddPostScreen(),
    ChatPage(),
    SettingsPage(),
  ];

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('PetMe'),
        backgroundColor: Colors.pink[300],
        actions: [
          IconButton(
              onPressed: signUserOut,
              icon: const Icon(Icons.logout
              )
          )
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 7),
            child: GNav(
              gap: 10,
              duration: const Duration(microseconds: 100),
              backgroundColor: Colors.white54,
              color: Colors.pink[200],
              activeColor: Colors.pink,
              curve: Curves.bounceIn,
              // tabBorder: Border.all(color: Colors.black87),
              // tabBackgroundColor: Colors.black,
              padding: const EdgeInsets.all(10),
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.pets_outlined,
                  text: 'Pets',
                ),
                GButton(
                  icon: Icons.camera_alt_outlined,
                  text: 'Post',
                ),
                GButton(
                  icon: Icons.chat,
                  text: 'Chat',
                ),
                GButton(
                  icon: Icons.settings,
                  text: 'Settings',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
