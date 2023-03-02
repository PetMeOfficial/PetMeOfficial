import 'dart:typed_data';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petme/screens/FirebaseFunctions/firestore_methods.dart';
import 'package:petme/screens/HomeScreen/Navigation/pet_page.dart';
import 'package:petme/screens/HomeScreen/Navigation/settings_page.dart';
import 'package:petme/screens/HomeScreen/main_page.dart';


class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {

  Uint8List? _file;
  PageController pageController = PageController();

  void postImage() async {
    try {
      String res = await FirestoreMethods().uploadPost(
        _file!,
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
              "Create Post",
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
    // final UserProvider userProvider = Provider.of<UserProvider>(context);
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
                    "Upload Image",
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
        : Scaffold(
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
                    postImage();
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
            // POST FORM
            body: Column(
              children: <Widget>[
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
              ],
            ),
          );
  }
}