import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:petme/providers/user_provider.dart';
import 'package:petme/screens/MainScreen/Navigation/Settings/help.dart';
import 'package:petme/screens/MainScreen/Navigation/Settings/inviteafrd.dart';
import 'package:provider/provider.dart';
import '../../main_page.dart';
import 'constant.dart';
import 'profile_list_item.dart';
import 'package:petme/models/user.dart' as model;
import 'privacy.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends  State<ProfileScreen>{
  @override
  Widget build(BuildContext context) {
    return Center(
      // initTheme: kDarkTheme,
      child: Builder(
        builder: (context) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: ProfileScreenState(),
          );
        },
      ),
    );
  }
}

class ProfileScreenState extends StatefulWidget {
  const ProfileScreenState({super.key});
  @override
  State<ProfileScreenState> createState() => _ProfileScreenStateState();
}


class _ProfileScreenStateState extends State<ProfileScreenState> {
  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;

    // SizeConfig().init(context);
    ScreenUtil.init(context,
      designSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
      //   height: MediaQuery.of(context).size.height,
      //   width: MediaQuery.of(context).size.width,
      //   // allowFontScaling: true
      // allo
    );


    var profileInfo = Expanded(
      child: Column(
        children: <Widget>[
          Container(
            height: kSpacingUnit.w * 9,
            width: kSpacingUnit.w * 9,
            margin: EdgeInsets.only(
                top: kSpacingUnit.w * 0.5,
                right: kSpacingUnit.w * 3.5
            ),
            child: Stack(
              children: <Widget>[
                Stack(
                  children: [
                    CircleAvatar(
                      radius: kSpacingUnit.w * 4.5,
                      // backgroundImage: AssetImage('assets/avatar.png'),
                      backgroundImage: NetworkImage(user.profilePicUrl),
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {

                  },
                  child: Stack(
                    children: <Widget>[
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: kSpacingUnit.w * 4.5,
                            backgroundImage: NetworkImage(user.profilePicUrl),
                          )
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          height: kSpacingUnit.w * 2.5,
                          width: kSpacingUnit.w * 2.5,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            heightFactor: kSpacingUnit.w * 1.5,
                            widthFactor: kSpacingUnit.w * 1.5,
                            child: Icon(
                              LineAwesomeIcons.pen,
                              color: kDarkPrimaryColor,
                              size: ScreenUtil().setSp(kSpacingUnit.w * 1.5),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: kSpacingUnit.w * 2.5,
                    width: kSpacingUnit.w * 2.5,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      heightFactor: kSpacingUnit.w * 1.5,
                      widthFactor: kSpacingUnit.w * 1.0,
                      child: Icon(
                        LineAwesomeIcons.pen,
                        color: kDarkPrimaryColor,
                        size: ScreenUtil().setSp(kSpacingUnit.w * 1.5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: kSpacingUnit.w * 1),
          Container(
            margin: EdgeInsets.only(right: kSpacingUnit.w * 3.5),
            child: Text(
              user.username.toUpperCase(),
              style: kTitleTextStyle,
            ),
          ),
          SizedBox(height: kSpacingUnit.w * 0.5),
          Container(
            margin: EdgeInsets.only(top: kSpacingUnit.w * 0.5, right: kSpacingUnit.w * 3.5),
            child: Text(
              user.email,
              style: kCaptionTextStyle,
            ),
          ),
          SizedBox(height: kSpacingUnit.w * 1.5),
        ],
      ),
    );

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

    var header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: kSpacingUnit.w * 3),
        GestureDetector(
          onTap: () => Get.offAll(() => const MainPage()),
          child: Icon(
            LineAwesomeIcons.arrow_left,
            size: ScreenUtil().setSp(kSpacingUnit.w * 3),
          ),
        ),
        profileInfo,
        // themeSwitcher,
        SizedBox(width: kSpacingUnit.w * 2),
      ],
    );

    return Center(
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: Column(
              children: <Widget>[
                SizedBox(height: kSpacingUnit.w * 2),
                header,
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PrivacyPolicyPage()),
                                (Route<dynamic> route) => true,
                          );

                        },
                        child: const ProfileListItem(
                          icon: LineAwesomeIcons.user_shield,
                          text: 'Privacy',

                        ),
                      ),

                      GestureDetector(
                        onTap: (){
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HelpSupportPage()),
                                  (Route<dynamic> route) => true
                          );

                        },
                        child: const ProfileListItem(
                          icon: LineAwesomeIcons.question_circle,
                          text: 'Help & Support',
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const InviteFriendPage()),
                                  (Route<dynamic> route) => true
                          );

                        },
                        child: const ProfileListItem(
                          icon: LineAwesomeIcons.user_plus,
                          text: 'Invite a Friend',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          FirebaseAuth.instance.signOut().then((value) => Get.snackbar(
                              "Signing Out", "Log in to Continue"));
                        },
                        child: const ProfileListItem(
                          icon: LineAwesomeIcons.alternate_sign_out,
                          text: 'Logout',
                          // hasNavigation: false,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}