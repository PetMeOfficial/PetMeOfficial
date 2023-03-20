import 'dart:typed_data';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petme/screens/FirebaseFunctions/firestore_methods.dart';
import 'package:petme/models/user.dart' as model;
import 'package:petme/screens/HomeScreen/main_page.dart';
import 'package:provider/provider.dart';

import '../../../../providers/user_provider.dart';
import '../../../providers/user_provider.dart';


class AddBlog extends StatefulWidget {
  const AddBlog({Key? key}) : super(key: key);

  @override
  State<AddBlog> createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {

  Uint8List? _file;
  final TextEditingController descriptionController = TextEditingController();
  PageController pageController = PageController();
  final _blogName = TextEditingController();
  final _blogTitle = TextEditingController();
  final _blogDescription = TextEditingController();


  void blogImage(
      String username,
      String blogUrl,
      String description,
      String blogId,
      String uid,
      String profilePicUrl,
      String blogName,
      String blogTitle,
      String blogDescription,
      ) async {
    try {
      String res = await FirestoreMethods().uploadBlog(
         username,
         blogUrl,
         description,
         blogId,
         uid,
         profilePicUrl,
         blogName,
         blogTitle,
         blogDescription,
      );

      if (res == "Success") {
        debugPrint("Successful");
      } else {
        debugPrint("Failed");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  pickImage(ImageSource source) async {
    final ImagePicker imagepicker = ImagePicker();
    XFile? file = await imagepicker.pickImage(source: source);
    if (file != null) {
      return await file.readAsBytes();
    }
    debugPrint("No Image Selected");
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  selectImage(parentContext) {
    return showDialog(
        context: parentContext,
        builder: (context) {
          return SimpleDialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 1,
            backgroundColor: Colors.black87,
            title: const Text(
              "Create Blog",
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
                child: const Text(
                  "From Camera",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              SimpleDialogOption(
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
                padding:
                const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                child: const Text(
                  "From Gallery",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              SimpleDialogOption(
                child: const Text(
                  "Cancel",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainPage()));
                  final snack = SnackBar(
                    duration: const Duration(seconds: 2),
                    content: const Center(
                      child: Text(
                        "Cancelled!",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    margin: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 12),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.red[300],
                    elevation: 0,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snack);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    return _file == null
        ? Container(
      color: Colors.deepPurple[100],
      padding: const EdgeInsets.all(100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            child: const Text(
              "Upload Blog",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black87),
            ),
          ),
          AvatarGlow(
            endRadius: 150,
            glowColor: Colors.pinkAccent,
            repeatPauseDuration: const Duration(milliseconds: 100),
            duration: const Duration(milliseconds: 3000),
            child: IconButton(
              icon: const Icon(Icons.camera_alt),
              iconSize: 70,
              color: Colors.black87,
              onPressed: () => selectImage(context),
            ),
          ),
        ],
      ),
    )
        : // OR Statement
    Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: clearImage,
        ),
        title: const Text(
          'Selected Image',
        ),
        centerTitle: false,
        actions: <Widget>[
          TextButton(
            onPressed: () {
              blogImage(
                user.username,
                user.uid,
                user.profilePicUrl,
                _blogName.text,
                _blogTitle.text,
                _blogDescription.text,
                _blogDescription.text,
                _blogDescription.text,
                _blogDescription.text,
              );
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MainPage()));
              final snackBar = SnackBar(
                content: const Center(
                  child: Text("Successfully Posted !",
                      style: TextStyle(
                        color: Colors.black,
                        // fontWeight: FontWeight.bold,
                        fontSize: 20,
                      )),
                ),
                duration: const Duration(seconds: 3),
                backgroundColor: Colors.green[200],
                margin: const EdgeInsets.symmetric(
                    vertical: 16, horizontal: 12),
                behavior: SnackBarBehavior.floating,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            child: const Text(
              "Post",
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0),
            ),
          )
        ],
      ),
      backgroundColor: Colors.pink[100],
      // POST FORM
      body: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const Divider(),
              SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // CircleAvatar(
                    //   radius: 25,
                    //   child: SizedBox(
                    //     width: MediaQuery.of(context).size.width * 0.1,
                    //     child: Text(user.username, style: const TextStyle(fontWeight: FontWeight.bold),),
                    //   ),
                    // ),
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                        user.profilePicUrl,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: TextField(
                        controller: descriptionController,
                        decoration: const InputDecoration(
                          hintText: 'Write A Caption for Post ...',
                          border: InputBorder.none,
                        ),
                        maxLines: 3,
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: SizedBox(
                      height: 300.0,
                      width: 300.0,
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Container(
                          // height: 500,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                alignment: FractionalOffset.center,
                                image: MemoryImage(_file!),
                              )),
                        ),
                      ),
                    ),
                  ),
                ],

              ),
              const Divider(),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _blogName,
                textInputAction: TextInputAction.next,
                style: const TextStyle(
                  color: Colors.black,
                ),
                // onChanged: (value) {
                //   print(value);
                // },
                validator: (val) =>
                val!.isEmpty ? 'Please enter the blog\'s name!' : null,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter the blog\'s name!',
                  hintStyle: TextStyle(
                    color: Colors.black54,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller:_blogTitle,
                textInputAction: TextInputAction.next,
                style: const TextStyle(
                  color: Colors.black,
                ),
                // onChanged: (value) {
                //   print(value);
                // },
                validator: (val) =>
                val!.isEmpty ? 'Please enter the blog\'s title!' : null,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  hintText: 'Enter the blog\'s title!',
                  hintStyle: TextStyle(
                    color: Colors.black54,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller:_blogDescription,
                textInputAction: TextInputAction.next,
                style: const TextStyle(
                  color: Colors.black,
                ),
                // onChanged: (value) {
                //   print(value);
                // },
                validator: (val) =>
                val!.isEmpty ? 'Please enter the blog\'s description!' : null,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Enter the blog\'s description!',
                  hintStyle: TextStyle(
                    color: Colors.black54,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.black,
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
