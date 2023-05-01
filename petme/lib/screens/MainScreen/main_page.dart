import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:petme/screens/MainScreen/Navigation/BlogSection/blogfeedpage.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../Authentication/auth_page.dart';
import '../../providers/user_provider.dart';
import 'Navigation/HomeScreen/home_page.dart';
import 'Navigation/Map/map_page.dart';
import 'Navigation/PetProfile/add_post_screen.dart';
import 'Navigation/Settings/settings_page.dart';
import 'package:petme/screens/MainScreen/Navigation/Settings/constant.dart';

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


  void initInfo()async {
    var androidInitialize = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitialize = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(android: androidInitialize, iOS: iosInitialize);
    // await flutterLocalNotificationsPlugin.initialize(initializationSettings, onDidReceiveNotificationResponse: (String? payload) async{
    //   try{
    //     if(payload != null && payload.isNotEmpty){
    //
    //     }else{
    //
    //     }
    //   // ignore: empty_catches
    //   }catch (e){
    //   }
    //   return;
    // });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async { 
      if (kDebugMode) {
        print("______________onMessage_________________");
      }
      if (kDebugMode) {
        print("onMessage: {${message.notification?.title}/${message.notification?.body}}");
      }

      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
        message.notification!.body.toString(), htmlFormatBigText: true,
        contentTitle: message.notification!.title.toString(), htmlFormatContentTitle: true,
      );

      AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
          'PetMe', 'PetMe', importance: Importance.max,
          styleInformation: bigTextStyleInformation, priority:Priority.max, playSound: true,
      );

      NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.show(0, message.notification?.title, message.notification?.body, platformChannelSpecifics,
          payload: message.data['body']);
      await flutterLocalNotificationsPlugin.initialize(initializationSettings, onDidReceiveBackgroundNotificationResponse:
      (NotificationResponse notificationResponse) async {}
      );
      Future showNotification({int id=0, String? title,String? body,String? payload,}) async{

      }
    },

    );

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
      if (kDebugMode) {
        print("User Granted Provisional Permission");
      }
    }else{
      if (kDebugMode) {
        print("User Declined or Did not Accept Permission");
      }
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
              "android_channel_id": "PetMe"
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
    const HomePage(),
    // MeetingsPage(),
    const BlogFeedPage(),
    const AddPostScreen(),
    const MapPage(),
    const SettingsPage(),
  ];

  void signUserOut() {
    FirebaseAuth.instance.signOut().then((value) => Get.snackbar(
        "Signing Out", "Log in to Continue"));
  }
  // var themeSwitcher = ThemeSwitcher(
  //   builder: (context) {
  //     return AnimatedCrossFade(
  //       duration: const Duration(milliseconds: 200),
  //       crossFadeState:
  //       ThemeProvider.of(context).brightness == Brightness.dark
  //           ? CrossFadeState.showFirst
  //           : CrossFadeState.showSecond,
  //       firstChild: GestureDetector(
  //         onTap: () {
  //           ThemeSwitcher.of(context).changeTheme(theme: kLightTheme);
  //           Get.snackbar("Light Mode", "Enabled");
  //         },
  //         child: Icon(
  //           LineAwesomeIcons.sun,
  //           size: ScreenUtil().setSp(kSpacingUnit.w * 3) as double,
  //         ),
  //       ),
  //       secondChild: GestureDetector(
  //         onTap: () {
  //           ThemeSwitcher.of(context).changeTheme(theme: kDarkTheme);
  //           Get.snackbar("Dark Mode", "Enabled");
  //         },
  //         child: Icon(
  //           LineAwesomeIcons.moon,
  //           size: ScreenUtil().setSp(kSpacingUnit.w * 3) as double,
  //         ),
  //       ),
  //     );
  //   },
  // );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [

            kDarkSecondaryColor,

            kLightPrimaryColor,
          ]
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          bottomOpacity: 0,
          title: Text(
            'PetMe',
            style: GoogleFonts.anton(
              textStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 25,
                color: Colors.white
              ),
            ),
          ),
          backgroundColor: const Color(0xFF487776),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: signUserOut,
                icon: const Icon(Icons.logout, color: Colors.white,
                )
            )
          ],
        )

        ,
        body: PageView(
          children: [_widgetOptions.elementAt(_selectedIndex)],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            // color: Colors.deepPurple[600],
            color: const Color(0xFF487776),
            // color: Colors.blue[900],
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
              child: GNav(
                gap: 10,
                duration: const Duration(microseconds: 100),
                color: const Color(0xFFCECCB8),
                activeColor: Colors.white,
                curve: Curves.easeIn,
                padding: const EdgeInsets.all(10),
                tabs: const [
                  GButton(
                    icon: FontAwesomeIcons.house,
                    // text: 'Home',
                  ),
                  GButton(
                    // icon: FontAwesomeIcons.userGroup,
                    icon: FontAwesomeIcons.pencil,
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
      ),
    );
  }
}
