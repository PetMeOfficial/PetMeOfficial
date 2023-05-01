import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:petme/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:petme/models/user.dart' as model;

class BlogsDetailsPage extends StatefulWidget {
  final snap;

  const BlogsDetailsPage({
    Key? key,

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
    final male = widget.snap['petGender'] == 'Male' ? true : false;


    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
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
                          SizedBox(
                            height: screenHeight * 0.115.toDouble(),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Text(
                                widget.snap['content'],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.0,
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
                                style: const TextStyle(
                                  color: Color(0xFF487776),
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
                            style: const TextStyle(
                              fontSize: 26.0,
                              color: Color(0xFF487776),
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