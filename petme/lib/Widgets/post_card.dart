import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:petme/providers/user_provider.dart';
import 'package:petme/screens/HomeScreen/Navigation/home_page.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class PostCard extends StatelessWidget {
  const PostCard({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        vertical: 10
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
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/eevie.png')
                ),
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(
                          left: 8
                        ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Username", style: TextStyle(fontWeight: FontWeight.bold),)
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
                        onTap: (){  },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 16),
                          child: Text(e),
                        ),
                      )).toList()
                    ),
                  ));
                }, icon: const Icon(Icons.more_vert)),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.35,
            width: double.infinity,
            child: Image.asset('assets/eevie.png',
              fit: BoxFit.cover,),
          ),
          //Likes and Comments section
          Row(
            children: [
              IconButton(
                  onPressed: (){},
                  icon: const Icon(
                    Icons.pets_outlined,
                    color: Colors.pink,
                  )
              ),
              IconButton(
                  onPressed: (){},
                  icon: const Icon(
                    Icons.comment_rounded,
                    color: Colors.pink,
                  )
              ),
            ],
          ),
          //Description
          Container(
            padding: const EdgeInsets.only(
              top: 8,
              left: 8,
            ),
            width: double.infinity,
            child: RichText(
              text: const TextSpan(
                style: TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: 'Username',
                    style: TextStyle(fontWeight: FontWeight.bold,)
                  ),
                  TextSpan(
                      text: '  Here is some description for replacement in the near future',
                      // style: TextStyle(fontWeight: FontWeight.bold,)
                  )
                ]
              ),
            ),
          ),
        ],
      ),
    );
  }
}
