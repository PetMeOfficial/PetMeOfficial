import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../Authentication/auth_page.dart';
import '../../providers/user_provider.dart';
import 'Navigation/HomeScreen/home_page.dart';
import 'Navigation/Map/map_page.dart';
import 'Navigation/Meetings/meetings_page.dart';
import 'Navigation/PetProfile/add_post_screen.dart';
import 'Navigation/Settings/settings_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String? mtoken = "";
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  var authController = AuthPage.instance;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState(){
    _firebaseMessaging.requestPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // TODO: handle the message
    });
    addData();
    requestPermission();
    initInfo();
    // getToken();
    super.initState();
  }

  // void getToken() async {
  //   await FirebaseMessaging.instance.getToken().then((token) {
  //     setState(() {
  //       mtoken = token;
  //       print("My token is $mtoken");
  //     });
  //   });
  // }

  void initInfo(){
    var androidInitialize = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitialize = const IOSInitializationSettings();
    var initializationSettings = InitializationSettings(android: androidInitialize, iOS: iosInitialize);
    flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: (String? payload) async{
      try{
        if(payload != null && payload.isNotEmpty){

        }else{

        }
      }catch (e){
      }
      return;
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async { 
      print("______________onMessage_________________");
      print("onMessage: {${message.notification?.title}/${message.notification?.body}}");

      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
        message.notification!.body.toString(), htmlFormatBigText: true,
        contentTitle: message.notification!.title.toString(), htmlFormatContentTitle: true,
      );

      AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
          'petme', 'petme','petme', importance: Importance.max,
          styleInformation: bigTextStyleInformation, priority:Priority.max, playSound: true,
      );

      NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.show(0, message.notification?.title, message.notification?.body, platformChannelSpecifics,
          payload: message.data['body']);

    });

  }

  void requestPermission() async{
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized){
      print("User Granted Permission");
    }else if (settings.authorizationStatus == AuthorizationStatus.provisional){
      print("User Granted Provisional Permission");
    }else{
      print("User Declined or Did not Accept Permission");
    }
  }

  void sendPushMessage(String token , body, title) async {
    try{
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=AAAAuNG07C0:APA91bH2OYAf0oXU0p1PwIzdDW9fDd3RAWoZxRSRu7rDEbqeRiGd4ZH_cFjgh930Y_xMFdYaFuPU7S4HsGyU1IlgMbkoUQGV-SOZO2qVpzB2pF4XeAwB77tjHNi803Ox1eqDjwtQZ6Ck'
        },
        body: jsonEncode(
          <String, dynamic>{

            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': body,
              'title': title,
            },

            "notification" : <String, dynamic>{
              "title":title,
              "body": body,
              "android_channel_id": "petme"
            },
            "to": token,
          },
        ),
      );
    }catch (e){
      if(kDebugMode){
        print("Error Push Notification");
      }
    }
  }

  addData() async {
    UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
  }

  int _selectedIndex = 0;

  static  final List<Widget> _widgetOptions = <Widget>[
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
        backgroundColor: Colors.deepPurple[300],
        elevation: 0.0,
        actions: [
          TextButton(
            onPressed: (){
              Get.toNamed('blogfeed');
            },
            child: Text("Blogs", style: TextStyle(color: Colors.white, fontSize: 20),),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                Colors.deepPurple[300]!,
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
              color: Colors.deepPurple[100],
              activeColor: Colors.deepPurple[400],
              curve: Curves.easeIn,
              // tabBorder: Border.all(color: Colors.black87),
              // tabBackgroundColor: Colors.black,
              padding: const EdgeInsets.all(11),
              tabs: const [
                GButton(
                  icon: FontAwesomeIcons.house,
                  // text: 'Home',
                ),
                GButton(
                  icon: FontAwesomeIcons.userGroup,
                  // text: 'Meetings',
                ),
                GButton(
                  // icon: Icons.pets,
                  icon: FontAwesomeIcons.paw,
                  // text: 'Pet Profile',
                ),
                GButton(
                  icon: FontAwesomeIcons.mapLocation,
                  // text: 'Map',
                ),
                GButton(
                  icon: FontAwesomeIcons.gear,
                  // text: 'Settings',
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
