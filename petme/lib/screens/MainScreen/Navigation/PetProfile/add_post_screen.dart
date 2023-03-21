import 'dart:typed_data';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petme/screens/FirebaseFunctions/firestore_methods.dart';
import 'package:petme/models/user.dart' as model;
import 'package:petme/screens/MainScreen/main_page.dart';
import 'package:provider/provider.dart';

import '../../../../providers/user_provider.dart';


class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {

  Uint8List? _file;
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController  captionController = TextEditingController();
  PageController pageController = PageController();
  final _petName = TextEditingController();
  final _petBreed = TextEditingController();
  final _petAge = TextEditingController();

  String _petGender = 'Male';
  var genders = [
    'Male',
    'Female',
  ];
  String _petSize = 'Medium';
  var sizes = [
    'Small',
    'Medium',
    'Large',
  ];
  String _petType = 'Dog';
  var types = [
    'Dog',
    'Cat',
    'Bird',
    'Rabbits'
  ];

  void postImage(
      String username,
      String uid,
      String profilePicUrl,
      String petName,
      String petBreed,
      String petAge,
      dynamic petGender,
      dynamic petSize,
      dynamic petType,
      ) async {
    try {
      String res = await FirestoreMethods().uploadPost(
        _file!,
        descriptionController.text,
        captionController.text,
        username,
        uid,
        profilePicUrl,
          _petName.text,
          _petBreed.text,
          _petAge.text,
          _petGender,
          _petSize,
          _petType,
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
              "Create Pet Profile",
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
          padding: const EdgeInsets.all(50),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: const Text(
                    "Create Pet Profile",
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
                    icon: const Icon(FontAwesomeIcons.camera),
                    iconSize: 50,
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
                    postImage(
                        user.username,
                        user.uid,
                        user.profilePicUrl,
                        _petName.text,
                        _petBreed.text,
                        _petAge.text,
                        _petGender,
                        _petSize,
                        _petType,
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
                              controller: captionController,
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
                      controller: _petName,
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      // onChanged: (value) {
                      //   print(value);
                      // },
                      validator: (val) =>
                      val!.isEmpty ? 'Please enter the pet\'s name!' : null,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        hintText: 'Enter the pet\'s name!',
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
                      controller: _petBreed,
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      // onChanged: (value) {
                      //   print(value);
                      // },
                      validator: (val) =>
                      val!.isEmpty ? 'Please enter the pet\'s breed!' : null,
                      decoration: const InputDecoration(
                        labelText: 'Breed',
                        hintText: 'Enter the pet\'s breed!',
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
                      controller: _petAge,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      // onChanged: (value) {
                      //   print(value);
                      // },
                      validator: (val) =>
                      val!.isEmpty ? 'Please enter the pet\'s age!' : null,
                      decoration: const InputDecoration(
                        labelText: 'Age',
                        hintText: 'Enter the pet\'s age!',
                        hintStyle: TextStyle(
                          color: Colors.black54,
                        ),
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),const SizedBox(height: 10.0),
                    TextFormField(
                      controller: descriptionController,
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      // onChanged: (value) {
                      //   print(value);
                      // },
                      validator: (val) =>
                      val!.isEmpty ? 'Please enter the description!' : null,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        hintText: 'Enter Description',
                        hintStyle: TextStyle(
                          color: Colors.black54,
                        ),
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            const Text(
                              "Gender",
                              style: TextStyle(fontSize: 18, color: Colors.black54),
                            ),
                            DropdownButton(
                              value: _petGender,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: genders.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _petGender = newValue!;
                                });
                              },
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text(
                              'Size',
                              style: TextStyle(fontSize: 18, color: Colors.black54),
                            ),
                            DropdownButton(
                              value: _petSize,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: sizes.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _petSize = newValue!;
                                });
                              },
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text(
                              'Type',
                              style: TextStyle(fontSize: 18, color: Colors.black54),
                            ),
                            DropdownButton(
                              value: _petType,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: types.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _petType = newValue!;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
          );
  }
}
