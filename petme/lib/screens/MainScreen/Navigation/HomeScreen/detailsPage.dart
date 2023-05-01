import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:petme/providers/user_provider.dart';
import 'package:petme/screens/MainScreen/Navigation/Settings/constant.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:petme/models/user.dart' as model;
import 'package:quickalert/quickalert.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main_page.dart';

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
  void showAlert() {
    QuickAlert.show(
        context: context, title: "Request Sent", type: QuickAlertType.success);
  }

  selectOption(parentContext) {
    return showDialog(
        context: parentContext,
        builder: (context) {
          return SimpleDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 1,
            backgroundColor: Color(0xFF487776),
            title: const Text(
              "Select Your Choice",
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () async {
                  Navigator.of(context).pop();
                  var text = "Hello, I came across your pet's profile on the pet adoption app and I'm interested in learning more about him/her. Could you please provide me with additional information regarding your pet's personality, health, and any other important details that you think would be helpful for me to know? I believe that your pet would be a great addition to my home and I look forward to hearing back from you. Thank you for your time!";
                  var whatsappUrl = "https://wa.me/$phone?text=$text";

                      await launch(whatsappUrl);

                  Future.delayed(const Duration(seconds: 7), () {
                    showAlert();
                  });
                },
                child: const Text(
                  "Contact through WhatsApp",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              SimpleDialogOption(
                onPressed: () async {
                  String body = "Hello, I came across your pet's profile on the pet adoption app and I'm interested in learning more about him/her. Could you please provide me with additional information regarding your pet's personality, health, and any other important details that you think would be helpful for me to know? I believe that your pet would be a great addition to my home and I look forward to hearing back from you. Thank you for your time!";
                  String subject = "Interested in adopting your pet";
                  String params = 'mailto:$email?subject=$subject&body=$body';
                  launch(params);
                  Navigator.of(context).pop();
                  DocumentSnapshot ownerSnapshot = await FirebaseFirestore.instance.collection('Adopters').doc(email).get();
                  String ownerEmail = ownerSnapshot.get('email');

                },
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                child: const Text(
                  "Contact through Email",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              SimpleDialogOption(
                child: const Text(
                  "Cancel",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainPage()));
                  final snack = SnackBar(
                    duration: const Duration(seconds: 2),
                    content: const Center(
                      child: Text(
                        "Cancelled!",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    margin: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 12),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.red[300],
                    elevation: 0,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snack);
                },
              ),
            ],
          );
        });
  }

  String? finalToken = "";
  String petOwnerName = "";
  String adopterName = "";
  String petOwnerId = "";
  String adopterId = "";
  String phone = "";
  String email = "";

  Future<void> shareProfile() async {
    await Share.share('Check out this profile right now!');
  }

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
              "android_channel_id": "PetMe"
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
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Color(0xFF487776),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  shareProfile();
                                },
                                child: const Icon(
                                  CupertinoIcons.share,
                                  // color: Colors.pink[400],
                                  color: Color(0xFF487776),
                                ),
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
                  color: kLightPrimaryColor.withOpacity(0.06),
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

                      GestureDetector(
                        onTap: () async {

                          var x = FirebaseAuth.instance.currentUser?.uid;
                          final adopterRef = FirebaseFirestore.instance
                              .collection("Adopters")
                              .where("username",
                                  isEqualTo: widget.snap['username'])
                              .get()
                              .then((value) => {
                                    value.docs.forEach((element) async {
                                      var UID = element.id;
                                      if (kDebugMode) {
                                        print(UID);
                                      }
                                      var tokenList = element.data();

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
                                          MapEntry eNum = tokenList.entries
                                              .firstWhere((element) =>
                                                  element.key == 'email');
                                          if (pNum != null) {
                                            if (kDebugMode) {
                                              print('key = ${eNum.key}');
                                            }
                                            if (kDebugMode) {
                                              print('value = ${eNum.value}');
                                            }
                                            email = eNum.value;
                                            if (kDebugMode) {
                                              print("email is : $email");
                                            }
                                          }

                                          setState(() {
                                            petOwnerName = username;
                                            adopterId = x!;
                                            petOwnerId = widget.snap2['uid'];
                                            // phone = widget.snap2['phoneNumber'].toString();
                                            phone = phoneNO;
                                            adopterName = user.username;
                                          });
                                        }
                                        if (finalToken != null) {
                                          /// Code for sending message
                                          try {
                                            sendPushMessage(
                                              finalToken!,
                                              "Hey ${petOwnerName.toUpperCase()}!",
                                              "Someone is Interested in your Pet",
                                            );
                                            print("Done ");
                                            selectOption(context);

                                          } catch (err) {
                                            if (kDebugMode) {
                                              print(err.toString());
                                            }
                                          }
                                        }
                                      }
                                    })
                                  });
                        },
                        child: Expanded(
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            elevation: 4.0,
                            color: const Color(0xFF487776),
                            // color: Colors.pink[400],
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
                            style: const TextStyle(
                              fontSize: 26.0,
                              color: Color(0xFF487776),
                              // color: Colors.pink[400],
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
                          style: const TextStyle(
                            fontSize: 16.0,
                            // color: Colors.pink[400],
                            color: Color(0xFF487776),
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
