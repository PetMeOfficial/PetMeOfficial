import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:petme/screens/HomeScreen/Navigation/map_page.dart';
import 'package:petme/screens/HomeScreen/Navigation/home_page.dart';
import 'package:petme/screens/HomeScreen/Navigation/settings_page.dart';
import 'package:petme/screens/HomeScreen/Navigation/add_post_screen.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';
import 'Navigation/meetings_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState(){
    _firebaseMessaging.requestPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // TODO: handle the message
    });
    addData();
    super.initState();
  }

  addData() async {
    UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
  }

  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    MeetingsPage(),
    AddPostScreen(),
    MapPage(),
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
        title: Text(
          'PetMe',
          style: GoogleFonts.anton(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 25,
            ),
          ),
        ),
        backgroundColor: Colors.pink[300],
        elevation: 0.0,
        actions: [
          TextButton(
            onPressed: (){
              Get.toNamed('blogfeed');
            },
            child: Text("Blogs", style: TextStyle(color: Colors.white, fontSize: 20),),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                Colors.pink[300]!,
              ),
            ),
          ),
        ],
      )

      ,
      body: PageView(
        children: [_widgetOptions.elementAt(_selectedIndex)],
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
                  icon: Icons.people_alt,
                  text: 'Meetings',
                ),
                GButton(
                  icon: Icons.camera_alt_outlined,
                  text: 'Post',
                ),
                GButton(
                  icon: Icons.map,
                  text: 'Map',
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
