import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:petme/providers/user_provider.dart';
import 'package:petme/screens/MainScreen/Navigation/Meetings/meetingschedule.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:petme/models/user.dart' as model;
import 'package:url_launcher/url_launcher.dart';

class DetailsPage extends StatefulWidget {
  final snap;
  final snap2;

  const DetailsPage({
    Key? key,
    // required this.pet,
    required this.snap2,
    required this.snap,
  }) : super(key: key);
  static String id = "DetailsPage";

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  String? finalToken = "";
  String petOwnerName = "";
  String adopterName = "";
  String petOwnerId = "";
  String adopterId = "";
  String phone = "";

  void sendPushMessage(String token, title, body) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAuNG07C0:APA91bH2OYAf0oXU0p1PwIzdDW9fDd3RAWoZxRSRu7rDEbqeRiGd4ZH_cFjgh930Y_xMFdYaFuPU7S4HsGyU1IlgMbkoUQGV-SOZO2qVpzB2pF4XeAwB77tjHNi803Ox1eqDjwtQZ6Ck'
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
            "notification": <String, dynamic>{
              "title": title,
              "body": body,
              "android_channel_id": "petme"
            },
            "to": token,
          },
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print("Error Push Notification");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    // final _db = FirestoreMethods();
    final male = widget.snap['petGender'] == 'Male' ? true : false;
    // var authController = AuthPage.instance;

    final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  SizedBox(
                    height: screenHeight * 0.55,
                    // width: screenWidth * 1.5,
                    child: Hero(
                      tag: widget.snap['petName'],
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image(
                          image:
                              NetworkImage(widget.snap['postUrl'].toString()),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: screenHeight * 0.5,
                    color: Colors.blue.withOpacity(0.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 60.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.pink[400],
                                ),
                              ),
                              Icon(
                                CupertinoIcons.share,
                                color: Colors.pink[400],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                  child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22.0,
                    vertical: 30.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      // ChangeNotifierProvider(
                      //   create: (context) => OwnerProvider(widget.snap["username"]),
                      //   child: const OwnerWidget(),
                      // ),
                      const SizedBox(
                        height: 90.0,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            widget.snap['description'],
                            maxLines: 4,
                            overflow: TextOverflow.fade,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
              Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.pink[400]?.withOpacity(0.06),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // const SizedBox(
                      //   width: 24.0,
                      // ),
                      GestureDetector(
                        onTap: () async {
                          // String token = widget.snap2['token'];
                          // String username = widget.snap['username'];
                          // print(token);
                          // print(username);
                          var x = FirebaseAuth.instance.currentUser?.uid;
                          final adopterRef = FirebaseFirestore.instance
                              .collection("Adopters")
                              .where("username",
                                  isEqualTo: widget.snap['username'])
                              .
                              // where("token", isEqualTo: widget.snap['token']).
                              get()
                              .then((value) => {
                                    value.docs.forEach((element) async {
                                      var UID = element.id;
                                      if (kDebugMode) {
                                        print(UID);
                                      }
                                      var tokenList = element.data();
                                      // var token = element.data().values;

                                      MapEntry entry = tokenList.entries
                                          .firstWhere((element) =>
                                              element.key == 'token');
                                      if (entry != null) {
                                        if (kDebugMode) {
                                          print('key = ${entry.key}');
                                        }
                                        if (kDebugMode) {
                                          print('value = ${entry.value}');
                                        }
                                        var LatestToken = entry.value;
                                        if (kDebugMode) {
                                          print(LatestToken);
                                        }
                                        setState(() {
                                          finalToken = LatestToken;
                                          if (kDebugMode) {
                                            print("My token is $finalToken");
                                          }
                                        });
                                      }
                                      MapEntry uname = tokenList.entries
                                          .firstWhere((element) =>
                                              element.key == 'username');
                                      if (uname != null) {
                                        if (kDebugMode) {
                                          print('key = ${uname.key}');
                                        }
                                        if (kDebugMode) {
                                          print('value = ${uname.value}');
                                        }
                                        var username = uname.value;
                                        if (kDebugMode) {
                                          print("petOwner is : $username");
                                        }
                                        if (kDebugMode) {
                                          print(
                                              "adopterName is : ${user.username}");
                                          print("phone is : ${user.username}");
                                        }
                                        MapEntry pNum = tokenList.entries
                                            .firstWhere((element) =>
                                                element.key == 'phoneNumber');
                                        if (pNum != null) {
                                          if (kDebugMode) {
                                            print('key = ${pNum.key}');
                                          }
                                          if (kDebugMode) {
                                            print('value = ${pNum.value}');
                                          }
                                          var phoneNO = pNum.value;
                                          if (kDebugMode) {
                                            print("phoneNO is : $pNum");
                                          }
                                          setState(() {
                                            petOwnerName = username;
                                            adopterId = x!;
                                            petOwnerId = widget.snap2['uid'];
                                            // phone = widget.snap2['phoneNumber'].toString();
                                            phone = phoneNO;
                                            adopterName = user.username;
                                            // print("My token is $finalToken");
                                          });
                                          Get.to(MeetingsSchedulingPage(
                                            petOwnerId: petOwnerId,
                                            adopterId: adopterId,
                                            ownerName: petOwnerName,
                                            adopterName: adopterName,
                                          ));
                                        }
                                        if (finalToken != null) {
                                          // Code for sending message
                                          try {
                                            sendPushMessage(
                                              finalToken!,
                                              "Hey ${petOwnerName.toUpperCase()}!",
                                              "Someone is Interested in your Pet",
                                            );
                                            var whatsappUrl =
                                                "https://wa.me/$phone?"
                                                "text=Dear%20${petOwnerName},"
                                                "\n\nI%20hope%20this%20message%20finds%20you%20well.%20I%20came%20across%20your%20post%20about%20your%20pet%20who%20needs%20a%20new%20home,%20and%20I%20wanted%20to%20express%20my%20interest%20in%20adopting%20him/her.%20I%20have%20been%20searching%20for%20a%20furry%20friend%20to%20add%20to%20my%20family,%20and%20your%20pet%20seems%20like%20the%20perfect%20fit."
                                                "\n\nI%20have%20experience%20with%20pets%20and%20have%20owned%20several%20dogs%20and%20cats%20in%20the%20past.%20I%20have%20a%20spacious%20home%20with%20a%20big%20backyard%20where%20your%20pet%20can%20play%20and%20get%20plenty%20of%20exercise.%20I%20am%20also%20willing%20to%20provide%20all%20the%20necessary%20care%20and%20attention%20that%20your%20pet%20needs,%20including%20regular%20vet%20check-ups%20and%20grooming."
                                                "\n\nIf%20you%20are%20still%20looking%20for%20a%20new%20home%20for%20your%20pet,%20I%20would%20be%20honored%20to%20give%20him/her%20a%20loving%20and%20caring%20home.%20Please%20let%20me%20know%20if%20you%20are%20willing%20to%20consider%20me%20as%20a%20potential%20adopter.%20I%20would%20be%20more%20than%20happy%20to%20answer%20any%20questions%20you%20may%20have."
                                                "\n\nThank%20you%20for%20considering%20me%20as%20a%20potential%20adopter%20for%20your%20beloved%20pet."
                                                "\n\nBest%20regards,"
                                                "\n\n${adopterName}";
                                            await canLaunch(whatsappUrl)
                                                ? await launch(whatsappUrl)
                                                : throw "Could Not Launch Url: $whatsappUrl";
                                          } catch (err) {
                                            if (kDebugMode) {
                                              print(err.toString());
                                            }
                                          }
                                        }

                                        // print(element.data());
                                        // print(UID);
                                        // print(token);
                                        // print(tokenList);
                                        // print(hello);
                                      }
                                    })
                                  });

                          // Create a query against the collection.
                          // var query = adopterRef.where("username", isEqualTo: "vish").snapshots().toString();
                          // print(query);

                          // String titleText = 'Title';
                          // String bodyText = 'Body';

                          // authController.sendPushMessage(token, titleText, bodyText);
                        },
                        // authController.sendPushMessage(token, body, title),

                        child: Expanded(
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            elevation: 4.0,
                            color: Colors.pink[400],
                            child: const Padding(
                              // padding: EdgeInsets.all(20.0),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 60, vertical: 30),
                              child: Text(
                                'Adoption',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32.0,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: Material(
              borderRadius: BorderRadius.circular(20.0),
              elevation: 6.0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 20.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                height: 140.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            widget.snap['petName'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 26.0,
                              color: Colors.pink[400],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              male ? "Male" : "Female",
                              style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 15.0,
                              ),
                            ),
                            Icon(
                              male
                                  ? LineAwesomeIcons.mars
                                  : LineAwesomeIcons.venus,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          widget.snap['petBreed'],
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.pink[400],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '${widget.snap['petAge']} years old',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
