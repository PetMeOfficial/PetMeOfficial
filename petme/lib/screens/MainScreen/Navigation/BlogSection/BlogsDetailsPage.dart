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

class BlogsDetailsPage extends StatefulWidget {
  final snap;
  // final snap2;

  const BlogsDetailsPage({
    Key? key,
    // required this.pet,
    // required this.snap2,
    required this.snap,
  }) : super(key: key);
  static String id = "DetailsPage";

  @override
  State<BlogsDetailsPage> createState() => _BlogsDetailsPageState();
}

class _BlogsDetailsPageState extends State<BlogsDetailsPage> {
  String? finalToken = "";
  String petOwnerName = "";
  String adopterName = "";
  String petOwnerId = "";
  String adopterId = "";


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
    model.User user = Provider.of<UserProvider>(context).getUser;
    // final _db = FirestoreMethods();
    final male = widget.snap['petGender'] == 'Male' ? true : false;
    // var authController = AuthPage.instance;


    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    // final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        // alignment: Alignment.,
        children: <Widget>[
          Column(
            children: <Widget>[
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  SizedBox(
                    height: screenHeight * 0.25,
                    width: screenWidth * 1.5,
                    child: Hero(
                      tag: widget.snap['title'],
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(45),
                        child: Image(
                          image: NetworkImage(widget.snap['postImage'].toString()),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  // Top Corners Icons Below!!!
                  // Container(
                  //   height: screenHeight * 0.5,
                  //   color: Colors.blue.withOpacity(0.0),
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(
                  //         horizontal: 20.0, vertical: 60.0),
                  //     child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       children: <Widget>[
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: <Widget>[
                  //             InkWell(
                  //               onTap: () {
                  //                 Navigator.pop(context);
                  //               },
                  //               child: Icon(
                  //                 Icons.arrow_back_ios,
                  //                 color: Colors.deepPurple[400],
                  //               ),
                  //             ),
                  //             Icon(CupertinoIcons.share,
                  //               color: Colors.deepPurple[400],),
                  //           ],
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
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
                          SizedBox(
                            height: screenHeight * 0.115.toDouble(),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Text(
                                widget.snap['content'],
                                // maxLines: 20,
                                // overflow: TextOverflow.fade,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 22.0,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: SingleChildScrollView(
                              child: Text(
                                "${widget.snap['datetime'].toString()}\n"
                                    "                 Written By: ${widget.snap['username']}",
                                // maxLines: 20,
                                // overflow: TextOverflow.fade,
                                style: TextStyle(
                                  color: Colors.deepPurple[300],
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
                    ),
                  )),
              // Container for Adoption Button !!!
              // Container(
              //   height: 150,
              //   decoration: BoxDecoration(
              //     color: Colors.deepPurple[400]?.withOpacity(0.06),
              //     borderRadius: const BorderRadius.only(
              //       topRight: Radius.circular(30.0),
              //       topLeft: Radius.circular(30.0),
              //     ),
              //   ),
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 22.0),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: <Widget>[
              //         // const SizedBox(
              //         //   width: 24.0,
              //         // ),
              //         GestureDetector(
              //           onTap: () async {
              //             // String token = widget.snap2['token'];
              //             // String username = widget.snap['username'];
              //             // print(token);
              //             // print(username);
              //             var x = FirebaseAuth.instance.currentUser?.uid;
              //             final adopterRef = FirebaseFirestore.instance.collection("Adopters").
              //             where("username", isEqualTo: widget.snap['username']).
              //             // where("token", isEqualTo: widget.snap['token']).
              //             get()
              //                 .then((value) => {
              //               value.docs.forEach((element) {
              //                 var UID = element.id;
              //                 if (kDebugMode) {
              //                   print(UID);
              //                 }
              //                 var tokenList = element.data();
              //                 // var token = element.data().values;
              //
              //                 MapEntry entry = tokenList.entries.firstWhere((element) => element.key=='token');
              //                 if(entry != null){
              //                   if (kDebugMode) {
              //                     print('key = ${entry.key}');
              //                   }
              //                   if (kDebugMode) {
              //                     print('value = ${entry.value}');
              //                   }
              //                   var LatestToken = entry.value;
              //                   if (kDebugMode) {
              //                     print(LatestToken);
              //                   }
              //                   setState(() {
              //                     finalToken = LatestToken;
              //                     if (kDebugMode) {
              //                       print("My token is $finalToken");
              //                     }
              //                   });
              //                 }
              //                 MapEntry uname = tokenList.entries.firstWhere((element) => element.key=='username');
              //                 if(uname != null){
              //                   if (kDebugMode) {
              //                     print('key = ${uname.key}');
              //                   }
              //                   if (kDebugMode) {
              //                     print('value = ${uname.value}');
              //                   }
              //                   var username = uname.value;
              //                   if (kDebugMode) {
              //                     print("petOwner is : $username");
              //                   }
              //                   if (kDebugMode) {
              //                     print("adopterName is : ${user.username}");
              //                   }
              //                   setState(() {
              //                     petOwnerName = username;
              //                     adopterId = x!;
              //                     // petOwnerId = widget.snap2['uid'];
              //                     adopterName = user.username;
              //                     // print("My token is $finalToken");
              //                   });
              //                   Get.to(MeetingsSchedulingPage(
              //                     petOwnerId: petOwnerId,
              //                     adopterId: adopterId,
              //                     ownerName: petOwnerName,
              //                     adopterName: adopterName,
              //                   ));
              //                 }
              //                 if(finalToken!=null){
              //                   // Code for sending message
              //                   try {
              //                     sendPushMessage(
              //                       finalToken!,
              //                       "Hey ${petOwnerName.toUpperCase()}!",
              //                       "Someone is Interested in your Pet",
              //                     );
              //
              //
              //                   }catch(err){
              //                     if (kDebugMode) {
              //                       print(err.toString());
              //                     }
              //                   }
              //                 }
              //
              //                 // print(element.data());
              //                 // print(UID);
              //                 // print(token);
              //                 // print(tokenList);
              //                 // print(hello);
              //               })
              //             });
              //
              //             // Create a query against the collection.
              //             // var query = adopterRef.where("username", isEqualTo: "vish").snapshots().toString();
              //             // print(query);
              //
              //             // String titleText = 'Title';
              //             // String bodyText = 'Body';
              //
              //             // authController.sendPushMessage(token, titleText, bodyText);
              //
              //           },
              //           // authController.sendPushMessage(token, body, title),
              //
              //           child: Expanded(
              //             child: Material(
              //               borderRadius: BorderRadius.circular(20.0),
              //               elevation: 4.0,
              //               color: Colors.deepPurple[400],
              //               child: const Padding(
              //                 // padding: EdgeInsets.all(20.0),
              //                 padding: EdgeInsets.symmetric(horizontal: 60, vertical: 30),
              //                 child: Text(
              //                   'Adoption',
              //                   style: TextStyle(
              //                     color: Colors.white,
              //                     fontWeight: FontWeight.bold,
              //                     fontSize: 32.0,
              //                   ),
              //                   textAlign: TextAlign.center,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // )
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 22.0,
                vertical: screenWidth * 0.47.toDouble(),
                // vertical: 180,
            ),
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
                  borderRadius: BorderRadius.circular(25.0),
                ),
                height: 120.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            widget.snap['title'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 26.0,
                              color: Colors.deepPurple[400],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            CircleAvatar(
                                radius: 27,
                                backgroundImage:
                                // snap['postUrl']
                                NetworkImage(
                                  widget.snap['profilePicUrl'],
                                )
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: <Widget>[
                    //     Text(
                    //       widget.snap['description'],
                    //       style: TextStyle(
                    //         fontSize: 16.0,
                    //         color: Colors.deepPurple[400],
                    //         fontWeight: FontWeight.w500,
                    //       ),
                    //     ),
                    //     // Text(
                    //     //   '${widget.snap['petAge']} years old',
                    //     //   style: const TextStyle(
                    //     //     color: Colors.grey,
                    //     //     fontWeight: FontWeight.w600,
                    //     //   ),
                    //     // ),
                    //   ],
                    // ),
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