import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petme/Widgets/post_card.dart';
import 'chatbot.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatBot()),
          );
        },
        child: Container(
          width: 60,
          height: 60,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.pink[400],
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



    );
  }
}