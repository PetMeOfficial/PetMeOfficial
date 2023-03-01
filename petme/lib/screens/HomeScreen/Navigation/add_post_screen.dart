import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petme/screens/FirebaseFunctions/firestore_methods.dart';
import 'package:petme/screens/Login/login_page.dart';


import '../../../providers/user_provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;

  void postImage() async {
    try{
      String res = await FirestoreMethods().uploadPost(
          _file!,
      );


      if(res == "Success"){
        debugPrint("Successful");
      }else{
        debugPrint("Failed");
      }
    } catch(e){
      debugPrint(e.toString());
    }
  }

  pickImage(ImageSource source) async {
    final ImagePicker imagepicker = ImagePicker();
    XFile? file = await imagepicker.pickImage(source: source);
    if(file != null){
      return await file.readAsBytes();
    }
    debugPrint("No Image Selected");
  }
  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  selectImage(parentContext){
    return showDialog(
        context: parentContext,
        builder: (context){
          return SimpleDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 1,
            backgroundColor: Colors.black87,
            title: const Text(
              "Create Post",style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),
            ),
            children: <Widget>[
              SimpleDialogOption(
                onPressed:  () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
                child: const Text("From Camera",style: TextStyle(fontSize: 20,color: Colors.white),),
              ),
              SimpleDialogOption(
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                child: const Text("From Gallery",style: TextStyle(fontSize: 20,color: Colors.white),),
              ),
              SimpleDialogOption(
                child: const Text("Cancel",style: TextStyle(fontSize: 20,color: Colors.white),),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    // final UserProvider userProvider = Provider.of<UserProvider>(context);
    final user = FirebaseAuth.instance.currentUser!;
    return _file == null? Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 10),
          child: const Text(
            "Upload Image" ,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.black87
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.camera_alt),
          iconSize: 50,
          color: Colors.pink,
          onPressed: () => selectImage(context),
        ),
        TextButton(
            onPressed: () => postImage(),
            child: const Text(
                'Post',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
        ),
      ],
    ):
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
              postImage();
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
