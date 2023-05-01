import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petme/Widgets/post_card.dart';
import 'package:provider/provider.dart';
import '../../../../providers/petProvider.dart';
import '../../../../providers/user_provider.dart';
import 'chatbot.dart';
import 'package:lottie/lottie.dart';

import 'detailsPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    final userProvider = context.read<UserProvider>();
    userProvider.refreshUser();
    final petsProvider = context.read<PetsProvider>();
    petsProvider.fetchPets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5DC),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Adopters').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot2) {
            return StreamBuilder(
              stream: FirebaseFirestore.instance.collection('posts').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(backgroundColor: Color(0xFF35BDD0),));
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                              create: (_) => PetsProvider(),
                              child: DetailsPage(
                                snap: snapshot.data!.docs[index].data(),
                                snap2: snapshot2.data!.docs[index].data(),
                                // pet: pet,
                              ),
                            ),
                          ),
                        );
                      },
                      child: PostCard(
                        snap: snapshot.data!.docs[index].data(),
                        snap2: snapshot2.data!.docs[index].data(),
                      ),
                    );
                    // );
                  },
                );
              },
            );
          }
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChatBot()),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 7,
              horizontal: 10,
          ),
          child: SizedBox(
            width: 60,
            height: 60,
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF487776),
                  ),
                ),
                Center(
                  child: Lottie.network(
                    'https://assets3.lottiefiles.com/packages/lf20_syqnfe7c.json',
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
