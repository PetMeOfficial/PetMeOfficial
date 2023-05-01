import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petme/Widgets/blog_card.dart';
import 'package:petme/screens/MainScreen/Navigation/BlogSection/BlogsDetailsPage.dart';
import 'package:petme/screens/MainScreen/Navigation/BlogSection/createBlogPage.dart';
import 'package:provider/provider.dart';
import '../../../../providers/petProvider.dart';
import '../../../../providers/user_provider.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Blogs'),
      //   backgroundColor: Colors.deepPurple[300],
      // ),
      backgroundColor:Color(0xFFF5F5DC),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Blogs').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Color(0xFF9ED72D),
            ));
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              // final pet = provider[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider(
                        create: (_) => PetsProvider(),
                        child: BlogsDetailsPage(
                          snap: snapshot.data!.docs[index].data(),
                        ),
                      ),
                    ),
                  );
                },
                child: BlogCard(
                  snap: snapshot.data!.docs[index].data(),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateBlogPage()),
              );
            },
          backgroundColor:Color(0xFF71B6B3),
            label: Row(
              children: [
                const Icon(
                  FontAwesomeIcons.pen,
                  size: 24,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "Create Blog",
                  style: GoogleFonts.dosis(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    ),
                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }
}
