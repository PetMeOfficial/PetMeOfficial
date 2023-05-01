import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:petme/Authentication/auth_page.dart';
import 'package:petme/providers/user_provider.dart';
import 'package:petme/screens/MainScreen/Navigation/BlogSection/createBlogPage.dart';
import 'package:petme/screens/MainScreen/Navigation/HomeScreen/home_page.dart';
import 'package:petme/screens/MainScreen/main_page.dart';
import 'package:petme/screens/Registration/SignUp.dart';
import 'package:petme/screens/Login/login_page.dart';
import 'package:petme/screens/SplashScreen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:petme/screens/Login/forgotPass.dart';
import 'package:provider/provider.dart';
import 'providers/petProvider.dart';
import 'screens/MainScreen/Navigation/BlogSection/blogfeedpage.dart';
import 'screens/firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling Background Message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => Get.put(AuthPage()));
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => UserProvider(),
      ),
      ChangeNotifierProvider(
          create: (_) => PetsProvider()
      ),
    ],
    child: GetMaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 0,
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      defaultTransition: Transition.size,
      transitionDuration: const Duration(milliseconds: 400),
      // routes: {
      //   'login': (context) => MyLogin(),
      //   'signup': (context) => const SignUp(),
      //   'splash': (context) => const SplashScreen(),
      //   'adopter': (context) => const adopterSignUp(),
      //   'forgot': (context) => const ForgotPass(),
      //   'mainPage': (context) => const MainPage(),
      // },
      getPages: [
        GetPage(name: '/login', page: () => MyLogin()),
        // GetPage(name: '/signup', page: () => const SignUp()),
        GetPage(name: '/blogpage', page: () => CreateBlogPage()),
        GetPage(name: '/blogfeed', page: () => BlogFeedPage()),
        GetPage(
            name: '/splash',
            page: () => const SplashScreen(),
            transition: Transition.downToUp),
        GetPage(name: '/adopter', page: () => const AdopterSignUp()),
        GetPage(name: '/forgot', page: () => const ForgotPass()),
        GetPage(name: '/mainPage', page: () => const MainPage()),
        GetPage(name: '/homePage', page: () => const HomePage()),
        // GetPage(name: '/requests', page: () => RequestScreen()),
      ],
    ),
  ));
}
