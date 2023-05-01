import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petme/screens/FirebaseFunctions/firestore_methods.dart';

class PostCard extends StatelessWidget {
  final snap;
  final snap2;
  const PostCard({Key? key, required this.snap, required this.snap2}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20
          ),
          child: Material(
            elevation: 20,
            borderRadius: BorderRadius.circular(10),
            // color: Colors.deepPurple[400],
            // color: Colors.greenAccent[400],
            color: const Color(0xFF83C0BE),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),

              ),
              // color: Colors.white,
              padding: const EdgeInsets.symmetric(
                vertical: 14,
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 16,
                    ).copyWith(right: 0),

                    child: Row(
                      children:  [
                        CircleAvatar(
                          radius: 24,
                          backgroundImage:
                          // snap['postUrl']
                          NetworkImage(
                              snap['profilePicUrl'],
                          )
                        ),
                        Expanded(
                            child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 8
                                ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${snap['username']}".toUpperCase(), style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white
                                  ),
                                  ),
                                  // Text(snap2['token'], style: const TextStyle(fontWeight: FontWeight.bold),),
                                // String token = widget.snap2['token'];
                                // print(token);
                                ],
                              ),
                            )
                        ),
                        IconButton(onPressed: () {
                          showDialog(context: context, builder: (context) =>  Dialog(
                            child: ListView(
                              padding: const EdgeInsets.symmetric(vertical: 16,),
                              shrinkWrap: true,
                              children: [
                                'Delete',
                              ].map((e) => InkWell(
                                onTap: () async {
                                  var x = FirebaseAuth.instance.currentUser?.uid;
                                  final adopterRef = FirebaseFirestore.instance.collection("Adopters").
                                  where("uid", isEqualTo: snap['uid']).get().then((value) => {
                                    value.docs.forEach((element) async {
                                      // var UID = element.id;
                                      if (kDebugMode) {
                                        print("Current User's UID is: $x");
                                      }
                                      if (kDebugMode) {
                                        print("snap id: ${snap['uid']}");
                                      }
                                      if(x == snap['uid']){
                                        FirestoreMethods().deletePost(snap['postId']);
                                        if (kDebugMode) {
                                          print("Will be deleted");
                                        }
                                      }else{
                                        if (kDebugMode) {
                                          print("Wrong User Deleting post");
                                        }
                                        if (kDebugMode) {
                                          print(snap['uid']);
                                        }
                                        // print(element.id);
                                      }

                                    })
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 16),
                                  child: Text(e),
                                ),
                              )).toList()
                            ),
                          ));
                        }, icon: const Icon(FontAwesomeIcons.ellipsisVertical, size: 22, color: Colors.white,)),
                      ],

                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.34,
                    width: double.infinity,
                    child: Image.network(
                      // 'assets/eevie.png',
                      snap['postUrl'].toString(),
                      fit: BoxFit.cover,),
                  ),

                  //Description
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      top: 3,
                      left: 27,
                    ),
                    width: double.infinity,
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(color: Colors.white, fontSize: 15),
                        children: [
                          TextSpan(
                            text: snap['username'],
                            style: const TextStyle(fontWeight: FontWeight.bold,)
                          ),
                          TextSpan(
                              text: '   ${snap['caption']}....',
                              // style: TextStyle(fontWeight: FontWeight.bold,)
                          )
                        ]
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}