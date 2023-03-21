import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:petme/providers/ownerProvider.dart';
import 'package:petme/providers/user_provider.dart';
import 'package:petme/screens/HomeScreen/main_page.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../Widgets/ownerWidget.dart';
import '../../../firebaseAuthe/auth_page.dart';
import '../../../models/posts.dart';
import '../../FirebaseFunctions/firestore_methods.dart';

class DetailsPage extends StatefulWidget {
  // final Post pet;
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
  String? userName = "";

  void sendPushMessage(String token , title, body) async {
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

  @override
  Widget build(BuildContext context) {
    final _db = FirestoreMethods();
    final male = widget.snap['petGender'] == 'Male' ? true : false;
    var authController = AuthPage.instance;


    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
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
                          image: NetworkImage(widget.snap['postUrl'].toString()),
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
                              Icon(CupertinoIcons.share,
                                color: Colors.pink[400],),
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

                          final adopterRef = FirebaseFirestore.instance.collection("Adopters").
                          where("username", isEqualTo: widget.snap['username']).
                          // where("token", isEqualTo: widget.snap['token']).
                          get()
                              .then((value) => {
                            value.docs.forEach((element) {
                              var UID = element.id;
                              print(UID);
                              var tokenList = element.data();
                              // var token = element.data().values;

                              MapEntry entry = tokenList.entries.firstWhere((element) => element.key=='token');
                              if(entry != null){
                                print('key = ${entry.key}');
                                print('value = ${entry.value}');
                                var LatestToken = entry.value;
                                print(LatestToken);
                                setState(() {
                                  finalToken = LatestToken;
                                  print("My token is $finalToken");
                                });
                              }
                              MapEntry uname = tokenList.entries.firstWhere((element) => element.key=='username');
                              if(uname != null){
                                print('key = ${uname.key}');
                                print('value = ${uname.value}');
                                var username = uname.value;
                                print(username);
                                setState(() {
                                  userName = username;
                                  // print("My token is $finalToken");
                                });
                              }
                              if(finalToken!=null){
                                // Code for sending message
                                try {
                                  sendPushMessage(
                                    finalToken!,
                                    "Adoption Request",
                                    "Someone sent you a Request!",
                                  );
                                  Get.snackbar("Notification Sent to Owner",
                                      "They will reply soon!",
                                      colorText: Colors.greenAccent[400],
                                      backgroundColor: Colors.white);
                                }catch(err){
                                  print(err.toString());
                                }
                              }

                              // print(element.data());
                              // print(UID);
                              // print(token);
                              // print(tokenList);
                              // print(hello);
                            })
                          });

                          // Create a query against the collection.
                          // var query = adopterRef.where("username", isEqualTo: "vish").snapshots().toString();
                          // print(query);

                          String titleText = 'Title';
                          String bodyText = 'Body';

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
                              padding: EdgeInsets.symmetric(horizontal: 60, vertical: 30),
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
                        Icon(
                          male ? LineAwesomeIcons.mars : LineAwesomeIcons.venus,
                          color: Colors.grey,
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