import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petme/Widgets/post_card.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // String username = "";

  // @override
  // void initState() {
  //   super.initState();
  //   getUsername();
  //   addData();
  // }

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

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
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Adopters').snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => const PostCard(),
            );
          },
        ),
      ),
    );
  }
}
