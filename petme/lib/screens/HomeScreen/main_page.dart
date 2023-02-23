import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:petme/screens/HomeScreen/Navigation/chat_page.dart';
import 'package:petme/screens/HomeScreen/Navigation/home_page.dart';
import 'package:petme/screens/HomeScreen/Navigation/settings_page.dart';

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
        backgroundColor: Colors.pink,
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
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              gap: 20,
              duration: Duration(microseconds: 9),
              backgroundColor: Colors.white,
              color: Colors.pink,
              activeColor: Colors.pink,
              tabBackgroundColor: Colors.black,
              padding: const EdgeInsets.all(15),
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
                  icon: Icons.search,
                  text: 'Search',
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