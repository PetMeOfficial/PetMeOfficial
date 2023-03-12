import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petme/Widgets/post_card.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // @override
  // void initState() {
  //   super.initState();
  //   getUsername();
  //   addData();
  // }


  // Gets username of current logged in user
  // void getUsername() async {
  //   DocumentSnapshot snap = await FirebaseFirestore.instance
  //       .collection("Adopers")
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();
  //
  //   debugPrint(snap.data() as String?);
  //
  //   setState(() {
  //     username = (snap.data() as Map<String, dynamic>)["Username"];
  //
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18))),
      child: Scaffold(
        backgroundColor: const Color(0xFF212121),


        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Adopters').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot2) {
            return StreamBuilder(
              stream: FirebaseFirestore.instance.collection('posts').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(backgroundColor: Colors.pink[400],));
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) => PostCard(
                    snap : snapshot.data!.docs[index].data(),
                    snap2 : snapshot2.data!.docs[index].data(),

                  ),
                );
              },
            );
          }

        ),





      ),
    );
  }
}
