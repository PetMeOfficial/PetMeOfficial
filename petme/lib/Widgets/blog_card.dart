import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  final snap;

  const BlogCard({
    Key? key,
    required this.snap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Material(
          elevation: 9,
          borderRadius: BorderRadius.circular(30),
          child: Column(
            children: [
              SizedBox(
                height: 290,
                width: 350,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //Image.
                    Container(
                      height: 200,
                      width: 390,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(
                              snap['postImage'].toString()),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                              snap['title'],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                              snap['description'],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                        ),


                      ],
                    ),

                  ],
                ),
              ),

            ],
          ),
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Card(
  //     margin: const EdgeInsets.symmetric(vertical: 10.0),
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(26.0),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         AppBar(
  //           title: Text("Blogs"),
  //           backgroundColor: Colors.transparent,
  //           elevation: 0.0,
  //         ),
  //         Container(
  //           height: 150.0,
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(16.0),
  //               topRight: Radius.circular(16.0),
  //             ),
  //             image: DecorationImage(
  //               image: NetworkImage(snap['postImage'].toString()),
  //               fit: BoxFit.cover,
  //             ),
  //                         ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.all(16.0),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 snap['title'],
  //                 style: Theme.of(context).textTheme.headline6,
  //               ),
  //               SizedBox(height: 8.0),
  //               Text(
  //                 snap['description'],
  //                 style: Theme.of(context).textTheme.subtitle1,
  //               ),
  //               SizedBox(height: 16.0),
  //               Text(
  //                 snap['content'],
  //                 style: Theme.of(context).textTheme.bodyText2,
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
