import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petme/Widgets/blog_card.dart';
import 'package:petme/Widgets/post_card.dart';
import 'package:petme/screens/HomeScreen/Navigation/createBlogPage.dart';
import 'package:provider/provider.dart';
import '../../../providers/petProvider.dart';
import '../../../providers/user_provider.dart';
import 'chatbot.dart';
import 'package:lottie/lottie.dart';

import 'detailsPage.dart';

class BlogFeedPage extends StatefulWidget {
  const BlogFeedPage({Key? key}) : super(key: key);

  @override
  State<BlogFeedPage> createState() => _BlogFeedPageState();
}

class _BlogFeedPageState extends State<BlogFeedPage> {
  @override
  void initState() {
    super.initState();
    final userProvider = context.read<UserProvider>();
    userProvider.refreshUser();
    final petsProvider = context.read<PetsProvider>();
    petsProvider.fetchPets();
  }

  // @override
  // Widget build(BuildContext context) {
  //   // TODO: implement build
  //   return Scaffold();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blogs'),
        backgroundColor: Colors.pink[300],
      ),
      backgroundColor:  Colors.white38,
      body: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('Blogs').snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(
                    backgroundColor: Colors.pink[400],
                  ));
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    // final pet = provider[index];
                    return BlogCard(
                        snap: snapshot.data!.docs[index].data(),
                      );
                  },
                );
              },
              ),



      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateBlogPage()),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 10,
          ),
          child: Container(
            width: 60,
            height: 60,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.pink[300],
                  ),
                ),
                Center(
                  child: Lottie.network(
                    'https://assets3.lottiefiles.com/packages/lf20_we7qtj1g.json',
                    repeat: true,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
