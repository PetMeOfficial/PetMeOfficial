import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:petme/firebaseAuthe/auth_page.dart';
import 'package:petme/providers/user_provider.dart';
import 'package:petme/screens/HomeScreen/Navigation/home_page.dart';
import 'package:petme/screens/HomeScreen/main_page.dart';
import 'package:petme/screens/Registration/Adopter/adopterSignUp.dart';
import 'package:petme/screens/Login/login_page.dart';
import 'package:petme/screens/Registration/Pet/petSignUp.dart';
import 'package:petme/screens/SplashScreen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:petme/screens/Login/forgotPass.dart';
import 'package:provider/provider.dart';
import '../providers/petProvider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => Get.put(AuthPage()));

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => UserProvider(),
      ),
      ChangeNotifierProvider(create: (_) => PetsProvider()),
    ],
    child: GetMaterialApp(
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
        GetPage(name: '/signup', page: () => const SignUp()),
        GetPage(
            name: '/splash',
            page: () => const SplashScreen(),
            transition: Transition.downToUp),
        GetPage(name: '/adopter', page: () => const adopterSignUp()),
        GetPage(name: '/forgot', page: () => const ForgotPass()),
        GetPage(name: '/mainPage', page: () => const MainPage()),
        GetPage(name: '/homePage', page: () => const HomePage()),
      ],
    ),
  ));
}
