import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final snap;
  const PostCard({Key? key, required this.snap}) : super(key: key);



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
                  radius: 18,
                  backgroundImage:
                  // snap['postUrl']
                  AssetImage('assets/eevie.png'),
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
                          Text(snap['username'], style: const TextStyle(fontWeight: FontWeight.bold),)
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
                        onTap: (){

                        },
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
            height: MediaQuery.of(context).size.height*0.36,
            width: double.infinity,
            child: Image.network(
              // 'assets/eevie.png',
              snap['postUrl'].toString(),
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
              top: 1,
              left: 12,
            ),
            width: double.infinity,
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: snap['username'],
                    style: const TextStyle(fontWeight: FontWeight.bold,)
                  ),
                  TextSpan(
                      text: '  ${snap['description']}',
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
