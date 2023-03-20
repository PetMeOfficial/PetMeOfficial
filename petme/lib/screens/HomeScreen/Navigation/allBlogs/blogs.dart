import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petme/screens/HomeScreen/Navigation/allBlogs/uploadblog.dart';

import '../../../../models/posts.dart';
import 'post.dart';

class Blogs extends StatefulWidget {
  const Blogs({Key? key}) : super(key: key);

  @override
  State<Blogs> createState() => _Blogs();
}

class _Blogs extends State<Blogs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 40,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Blogs', style: GoogleFonts.anton(textStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 25,),),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(child: ListView.builder(
              itemCount:5,
              itemBuilder: (context,index){
                return Padding (padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5,),
                  child: BlogPost(),
                );
              }))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddBlog()),);},  label: Row(
        children: [
          Icon(Icons.upload,
          size: 24,),
          SizedBox(
            width: 5,
          ),
          Text(
            "Create Blog",
            style: TextStyle(fontSize: 15),

          ),

      ],)),
    );
  }
}