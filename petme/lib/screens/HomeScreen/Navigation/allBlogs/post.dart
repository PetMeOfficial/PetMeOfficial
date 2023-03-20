import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BlogPost extends StatelessWidget {


  const BlogPost({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        height: 220,
        width: 100,
        child: Column(
          children: [
            //Image.
            Container(
              height: 155,
              width: 330,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                image: DecorationImage(
                  image: NetworkImage(
                      "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),


            SizedBox(
              height: 5,
            ),

            Text(
              " Blog post title ",
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}

